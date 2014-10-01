
# create and start a new volume
action :create do
	new_resource = @new_resource

	volume_name = new_resource.name

	new_resource.bricks.each do |brick| 
		unless brick then
			directory brick do
				action :create
				owner "root"
				group "root"
				mode 0755
			end
		end
	end

	volume_bricks = []
	# sort by name so the order is consistent if json changes
	new_resource.bricks.sort.each do |brick| 
		new_resource.peers.sort.each do |peer|
			volume_bricks << { :peer => peer, :brick => brick }
		end
	end

	if !volume_bricks.empty? && new_resource.ip_address == volume_bricks.first[:peer] then
		log("Executing master operations")

		# probe for peer servers, excluding ourself
		new_resource.peers[1..-1].each do |peer|
			
			execute "gluster peer probe #{peer}" do
			  action :run
			  not_if "egrep '^hostname.+=#{peer}$' /var/lib/glusterd/peers/*"
			end
			
		end

		# create volume if it doesn't exist
		unless ::File.exists?("/var/lib/glusterd/vols/#{volume_name}/info")
			# build command line
			replicas = "replica #{new_resource.peers.length}"
			# bricks/peers
			bricks = ""
			volume_bricks.each do |brick|
				bricks << " #{brick[:peer]}:#{brick[:brick]}"
			end

			if new_resource.force == true then
				force = "force"
			end

			stripes = ""
			if new_resource.bricks.length > 1 then
				stripes = "stripe #{new_resource.bricks.length}"
			end

			# execute
			cmd = "gluster volume create #{volume_name} #{stripes} #{replicas} transport tcp #{bricks} #{force}"
			execute cmd
		end

		# Start the volume
		execute "gluster volume start #{volume_name}" do
		  action :run
		  not_if { `gluster volume info #{volume_name} | grep Status`.include? 'Started' }
		end

	end

	# debug
	log(volume_bricks.first)
	log(new_resource.ip_address)
	log(volume_bricks)

end

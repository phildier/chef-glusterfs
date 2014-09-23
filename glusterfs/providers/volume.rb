
# create and start a new volume
action :create do
	new_resource = @new_resource

	device = new_resource.device || new_resource.mount_point
	volume_name = new_resource.name

	unless device then
		directory device do
			action :create
			owner "root"
			group "root"
			mode 0755
		end
	end

	volume_bricks = []
	new_resource.peers.each do |peer|
		log("dececting: peer #{peer} device #{device}")
		volume_bricks << { :peer => peer, :device => device }
	end

	if !volume_bricks.empty? && new_resource.ip_address == volume_bricks.first[:peer] then
		log("master detected")

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
				bricks << " #{brick[:peer]}:#{brick[:device]}"
			end

			if new_resource.force == true then
				force = "force"
			end

			# execute
			cmd = "gluster volume create #{volume_name} #{replicas} transport tcp #{bricks} #{force}"
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
	log(device)
	log(volume_bricks)

end

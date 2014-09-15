
# mount a volume on multiple servers
action :mount do
	new_resource = @new_resource

	volume_name = new_resource.name
	gluster_dir = "/etc/glusterfs.d/"
	directory new_resource.mount_point
	directory gluster_dir

	template "#{gluster_dir}/#{volume_name}.vol" do
		source "volume.vol.erb"
		variables ({
				:servers => new_resource.servers,
				:device => device
				})
	end

end

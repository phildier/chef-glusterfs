
# mount a volume on multiple servers
action :mount do
	new_resource = @new_resource

	volume_name = new_resource.name
	gluster_dir = "/etc/glusterfs.d/"
	directory new_resource.mount_point
	directory gluster_dir

	device = new_resource.device || new_resource.mount_point

	volume_file = "#{gluster_dir}/#{volume_name}.vol"

	template volume_file do
		source "volume.vol.erb"
		variables ({
				:servers => new_resource.servers,
				:device => device
				})
	end

	mount new_resource.mount_point do
		device volume_file
		fstype "glusterfs"
		pass 0
		action [:mount,:enable]
	end

end

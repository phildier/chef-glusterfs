
# mount a volume on multiple servers
action :mount do
	new_resource = @new_resource

	volume_name = new_resource.name
	gluster_dir = "/etc/glusterfs.d/"
	directory new_resource.mount_point
	directory gluster_dir

	mount new_resource.mount_point do
		device "#{new_resource.servers.first}:#{volume_name}"
		fstype "glusterfs"
		pass 0
		action [:mount,:enable]
	end

end

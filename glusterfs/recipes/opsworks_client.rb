
include_recipe "glusterfs::client_common"

opsworks_layer = node[:glusterfs][:layer]

servers = []
node[:opsworks][:layers][opsworks_layer][:instances].each do |name,peer|
	servers << peer[:private_ip]
end

glusterfs_mount node[:glusterfs][:volume_name] do
	servers servers
	bricks node[:glusterfs][:bricks]
	mount_point node[:glusterfs][:mount_point]
end

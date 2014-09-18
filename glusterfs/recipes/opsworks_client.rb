
include_recipe "glusterfs::client_common"

device = node[:glusterfs][:device] || node[:glusterfs][:mount_point]

opsworks_layer = node[:glusterfs][:layer]

servers = []
node[:opsworks][:layers][opsworks_layer][:instances].each do |name,peer|
	servers << peer[:private_ip]
end

glusterfs_mount node[:glusterfs][:volume_name] do
	servers servers
	device device
	mount_point node[:glusterfs][:mount_point]
end

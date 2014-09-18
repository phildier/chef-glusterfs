
include_recipe "glusterfs::client_common"

device = node[:glusterfs][:device] || node[:glusterfs][:mount_point]

servers = []
node[:glusterfs][:peers].each do |name,peer|
	servers << peer[:ip]
end

glusterfs_mount node[:glusterfs][:volume_name] do
	servers servers
	device device
	mount_point node[:glusterfs][:mount_point]
end

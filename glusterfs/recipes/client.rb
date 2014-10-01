
include_recipe "glusterfs::client_common"

servers = []
node[:glusterfs][:peers].each do |name,peer|
	servers << peer[:ip]
end

glusterfs_mount node[:glusterfs][:volume_name] do
	servers servers
	bricks node[:glusterfs][:bricks]
	mount_point node[:glusterfs][:mount_point]
end

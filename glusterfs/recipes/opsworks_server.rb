
include_recipe "glusterfs::server_common"

opsworks_layer = node[:glusterfs][:layer]

if node[:opsworks].attribute?(:instance) then
	ip = node[:opsworks][:instance][:private_ip] 
else 
	# for vagrant
	ip = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
end

gluster_peers = []
node[:opsworks][:layers][opsworks_layer][:instances].each do |name,instance|
	gluster_peers << instance[:private_ip]
end

glusterfs_volume node[:glusterfs][:volume_name] do
	ip_address ip
	peers gluster_peers
	device node[:glusterfs][:device]
	mount_point node[:glusterfs][:mount_point]
end

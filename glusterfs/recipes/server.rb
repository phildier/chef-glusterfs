
include_recipe "glusterfs::server_common"

ip = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first

gluster_peers = []
node[:glusterfs][:peers].sort.map do |name,instance|
	log("peer #{name}")
	gluster_peers.push instance[:ip]
end

glusterfs_volume node[:glusterfs][:volume_name] do
	ip_address ip
	peers gluster_peers
	bricks node[:glusterfs][:bricks]
	force true
end

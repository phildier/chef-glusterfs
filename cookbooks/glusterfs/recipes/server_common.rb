
include_recipe "glusterfs::default"

package "glusterfs-server"

service "glusterfs-server" do
	action [:enable,:start]
end

directory node[:glusterfs][:mount_point] || node[:glusterfs][:device]

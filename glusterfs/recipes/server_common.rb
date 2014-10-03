
include_recipe "glusterfs::default"

package "glusterfs-server"

service "glusterfs-server" do
	action [:enable,:start]
end



include_recipe "glusterfs::default"

package "glusterfs-server"
package "util-vserver"

service "glusterfs-server" do
	action [:enable,:start]
end


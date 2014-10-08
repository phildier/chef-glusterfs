
include_recipe "glusterfs::default"

package "glusterfs-server"
package "attr"

service "glusterfs-server" do
	action [:enable,:start]
end


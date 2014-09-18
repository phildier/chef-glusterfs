
include_recipe "glusterfs::default"

package "glusterfs-client"

directory node[:glusterfs][:mount_point]

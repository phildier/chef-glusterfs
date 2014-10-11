node[:gluseterfs][:bricks].each do |brick|
	bash "reset-brick-#{brick}" do
		code <<-EOH
setfattr -x trusted.glusterfs.volume-id #{brick}
setfattr -x trusted.gfid #{brick}
rm -rf #{brick}/.glusterfs
		EOH
	end
end

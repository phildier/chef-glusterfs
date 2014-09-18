actions :create, :mount
default_action :create

attribute :peers,		:kind_of => Array
attribute :device,		:kind_of => [String, NilClass]
attribute :ip_address,	:kind_of => [String, NilClass]
attribute :mount_point,	:kind_of => [String, NilClass],			:default => "/gluster"
attribute :force,		:kind_of => [TrueClass, FalseClass],	:default => false

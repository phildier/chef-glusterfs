actions :mount
default_action :mount

attribute :servers,		:kind_of => Array
attribute :device,		:kind_of => [String, NilClass]
attribute :mount_point,	:kind_of => [String, NilClass],			:default => "/gluster"

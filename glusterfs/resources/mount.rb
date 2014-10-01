actions :mount
default_action :mount

attribute :servers,		:kind_of => Array
attribute :bricks,		:kind_of => Array
attribute :mount_point,	:kind_of => [String, NilClass],			:default => "/gluster"

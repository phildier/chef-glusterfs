actions :create, :mount
default_action :create

attribute :peers,		:kind_of => Array
attribute :bricks,		:kind_of => Array
attribute :ip_address,	:kind_of => [String, NilClass]
attribute :force,		:kind_of => [TrueClass, FalseClass],	:default => false

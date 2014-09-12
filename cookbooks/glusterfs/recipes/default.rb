#
# Cookbook Name:: glusterfs
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

  apt_repository "ubuntu-glusterfs-3.4" do
    uri "http://ppa.launchpad.net/semiosis/ubuntu-glusterfs-3.4/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    keyserver "keyserver.ubuntu.com"
    key "774BAC4D"
    deb_src true
    not_if do
      File.exists?("/etc/apt/sources.list.d/ubuntu-glusterfs-3.4.list")
    end
  end

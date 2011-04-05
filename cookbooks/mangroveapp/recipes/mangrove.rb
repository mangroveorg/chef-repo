#
# Cookbook Name:: mangroveapp
# Recipe:: mangrove
#
#

include_recipe "python::pip"
include_recipe "python::virtualenv"

user "mangrover" do
  username "mangrover"
  comment "Mangrove User"
  uid "230584"
  gid "users"
  home "/home/mangrover"
  shell "/bin/bash"
  password "$6$TZTze7VZ3rH4Ta8F$pJ1Yxm2B4sIQ9YkeM/NAstypZIQMC00zrVXXqfwEbm5CpBZGtiaP80/xfIuLxn3GNtFUmqWTBZ/f/5phYo7XW1"
end

directory "/home/mangrover" do
  owner "mangrover"
  group "users"
  mode "0755"
  action :create
end


# install sqlite3 using packages
sqlite_packages = value_for_platform(
    ["centos","redhat","fedora"] => 
        {"default" => ["sqlite3", "sqlite"]},
    "default" => 
        ["sqlite3", "sqlite"]
  )

sqlite_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# install couchdb using packages
couchdb_packages = value_for_platform(
    ["centos","redhat","fedora"] => 
        {"default" => ["couchdb"]},
    "default" => 
        ["couchdb"]
  )

couchdb_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# install scms using packages
scm_packages = value_for_platform(
    ["centos","redhat","fedora"] => 
        {"default" => ["git"]},
    "default" => 
        ["git"]
  )

scm_packages.each do |pkg|
  package pkg do
    action :install
  end
end

# create a Python 2.7 virtualenv
python_virtualenv "/home/mangrover/awe_ve" do
  interpreter "python2.7"
  owner "mangrover"
  group "users"
  action :create
end

git "/home/mangrover/mangrove" do
  repository "git://github.com/mangroveorg/mangrove.git"
  reference "develop"
  user "mangrover"
  group "users"
  action :checkout
end


bash "mangrove_apps" do
  code <<-EOH
   (source /home/mangrover/awe_ve/bin/activate && cd /home/mangrover/mangrove && pip install -r requirements.pip)
  EOH
end

python_pip "gunicorn" do
  virtualenv "/home/mangrover/awe_ve"
  action :install
end

bash "mangrove_apps" do
  code <<-EOH
   (source /home/mangrover/awe_ve/bin/activate && cd /home/mangrover/mangrove/src/datawinners && gunicorn_django -D -b 0.0.0.0:8000 --pid=mangrove_gunicorn)
  EOH
end




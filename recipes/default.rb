package "ejabberd"

service "ejabberd" do
  action :enable
  supports :restart => true
end

directory "/etc/ejabberd" do
  owner "vagrant"
  mode "0755"
  action :create
end

template "/etc/ejabberd/ejabberd.cfg" do
  source "ejabberd.cfg.erb"
  mode 0755
  variables :domains => node['domains']
  action :create
  notifies :restart, resources(:service => "ejabberd")
end

# execute "add ejabberd admin user" do
#   command "ejabberdctl register admin #{node[:base][:jabber_domain]} #{node[:base][:jabber_admin_password]}"
# end

service "ejabberd" do
  action :start
end

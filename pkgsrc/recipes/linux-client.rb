remote_file "/tmp/pkgsrc-bootstrap.tar" do
  source node['pkgsrc']['bootstrap_tarball']['url']
  action :create_if_missing
end

execute "tar xvf /tmp/pkgsrc-bootstrap.tar" do
  cwd "/"
  creates "/usr/pkg/sbin/pkg_add"
end

repo = node['pkgsrc']['package_server']
dependencies = node['pkgsrc']['pkgin']['dependencies'].map { |d| d.join('-') }
pkgin_version = node['pkgsrc']['pkgin']['version']

dependencies.each do |dep|
  execute "Install dependency #{dep}" do
    target = ::File.join(repo, dep)
    command "/usr/pkg/sbin/pkg_add #{target}"
    not_if '/usr/pkg/sbin/pkg_info -e #{dep}'
  end
end

execute "Install pkgin version #{pkgin_version}" do
  command = "/usr/pkg/sbin/pkg_add pkgin-#{pkgin_version}"
  not_if '/usr/pkg/sbin/pkg_info -e pkgin'
end

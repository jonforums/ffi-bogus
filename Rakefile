require 'rubygems'
require 'rubygems/package_task'

gem_spec = Gem::Specification.load('ffi.gemspec')
Gem::PackageTask.new(gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
  pkg.package_dir = 'pkg'
end

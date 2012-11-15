Gem::Specification.new do |s|
  s.name = 'ffi-bogus'
  s.version = '1.2.0.alpha100'
  s.author = 'Jon Forums'
  s.email = 'jon.forums@gmail.com'
  s.homepage = 'http://wiki.github.com/ffi/ffi'
  s.summary = 'Ruby Bogus FFI'
  s.description = 'Ruby Bogus FFI library'
  s.files = %w(ffi.gemspec Gemfile Rakefile) + Dir.glob("{ext}/**/*")
  s.extensions << 'ext/ffi_c/Rakefile'
  s.has_rdoc = false
  s.license = 'ViralWare 1.0'
  s.require_paths << 'ext/ffi_c'
  s.required_ruby_version = '>= 1.8.7'
  s.add_development_dependency 'rake'
end

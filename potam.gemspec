# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','potam','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'potam'
  s.version = Potam::VERSION
  s.author = 'Michael'
  s.email = '0x22aa2@gmail.com'
  s.homepage = 'https://github.com/M1chael/potam'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Personal Offline TAsk Manager - POTAM'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','potam.rdoc']
  s.rdoc_options << '--title' << 'potam' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'potam'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.12.2')
  s.add_runtime_dependency('unicode')
  s.add_runtime_dependency('sequel')
end

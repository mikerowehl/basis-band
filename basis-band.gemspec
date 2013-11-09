require File.expand_path('../lib/basis-band/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'basis-band'
  s.version = BasisBandMeta::VERSION
  s.summary = 'Provides access to data from mybasis.com'
  s.description = 'A library and collection of tools for exporting monitoring data from the website for the Basis B1 Band device. See http://mybasis.com'
  s.authors = ['Mike Rowehl']
  s.email = 'mikerowehl@gmail.com'
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.test_files = Dir["{test}/**/*.rb"]
  s.executables = ['basis-band', 'basis-band-login']
  s.add_runtime_dependency 'json'
  s.homepage = 'http://github.com/mikerowehl/basis-band'
  s.license = 'MIT'
end

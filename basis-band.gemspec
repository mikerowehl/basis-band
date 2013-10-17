require File.expand_path('../lib/basis-band/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'basis-band'
  s.version = BasisBand::VERSION
  s.date = '2013-10-16'
  s.summary = 'Provides access to data from mybasis.com'
  s.description = 'A library and collection for tools for exporting monitoring data from the website for the Basis B1 Band device. See http://mybasis.com'
  s.authors = ['Mike Rowehl']
  s.email = 'mikerowehl@gmail.com'
  s.files = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.test_files = Dir["{test}/**/*.rb"]
  s.executables = ['basis-band']
  s.homepage = 'http://github.com/mikerowehl/basis-band'
  s.license = 'MIT'
end

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jp_zip_code/version'

Gem::Specification.new do |spec|
  spec.name          = 'jp_zip_code'
  spec.version       = JpZipCode::VERSION
  spec.authors       = ['kimromi']
  spec.email         = ['hiromi19860101@gmail.com']

  spec.summary       = 'convert from zip-code to japan address (include Roman address)'
  spec.description   = 'convert from zip-code to japan address (include Roman address)'
  spec.homepage      = 'http://kimromi.hatenablog.jp/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rubyzip'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end

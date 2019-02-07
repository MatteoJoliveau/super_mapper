# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_mapper/version'

Gem::Specification.new do |spec|
  spec.name    = 'super_mapper'
  spec.version = SuperMapper::VERSION
  spec.authors = ['Matteo Joliveau']
  spec.email   = ['matteojoliveau@gmail.com']

  spec.summary     = 'Quick and simple mapping between classes'
  spec.description = <<~DESCRIPTION
    SuperMapper is a quick and simple mapper between Ruby object.
    Define a mapping between attribute readers and writers and automatically convert classes
  DESCRIPTION
  spec.homepage = 'https://github.com/matteojoliveau/super_mapper'
  spec.license  = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri']    = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/matteojoliveau/super_mapper'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.63.1'
end

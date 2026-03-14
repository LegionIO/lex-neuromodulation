# frozen_string_literal: true

require_relative 'lib/legion/extensions/neuromodulation/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-neuromodulation'
  spec.version       = Legion::Extensions::Neuromodulation::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Neuromodulation'
  spec.description   = 'Neuromodulatory system modeling dopamine, serotonin, norepinephrine, and acetylcholine pathways for brain-modeled agentic AI'
  spec.homepage      = 'https://github.com/LegionIO/lex-neuromodulation'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-neuromodulation'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-neuromodulation'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-neuromodulation'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-neuromodulation/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-neuromodulation.gemspec Gemfile]
  end
  spec.require_paths = ['lib']
end

# frozen_string_literal: true

require 'legion/extensions/neuromodulation/version'
require 'legion/extensions/neuromodulation/helpers/constants'
require 'legion/extensions/neuromodulation/helpers/modulator'
require 'legion/extensions/neuromodulation/helpers/modulator_system'
require 'legion/extensions/neuromodulation/runners/neuromodulation'

module Legion
  module Extensions
    module Neuromodulation
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end

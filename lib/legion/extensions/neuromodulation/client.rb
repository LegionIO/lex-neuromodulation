# frozen_string_literal: true

require 'legion/extensions/neuromodulation/helpers/constants'
require 'legion/extensions/neuromodulation/helpers/modulator'
require 'legion/extensions/neuromodulation/helpers/modulator_system'
require 'legion/extensions/neuromodulation/runners/neuromodulation'

module Legion
  module Extensions
    module Neuromodulation
      class Client
        include Runners::Neuromodulation

        def initialize(system: nil, **)
          @neuromod_system = system || Helpers::ModulatorSystem.new
        end

        private

        attr_reader :neuromod_system
      end
    end
  end
end

require 'vagrant/action'
require_relative '../helpers'

module VagrantPlugins
  module R10k
    module Action
      class Base

        include R10K::Logging

        def self.validate
          Vagrant::Action::Builder.new.tap do |b|
            b.use Action::Validate
          end
        end

        def self.deploy
          Vagrant::Action::Builder.new.tap do |b|
            b.use Action::Validate
            b.use Action::Deploy
          end
        end

        include VagrantPlugins::R10k::Helpers

        def initialize(app, env)
          @app = app
          @env = env
          klass = self.class.name.downcase.split('::').last
          @logger = Log4r::Logger.new("vagrant::r10k::#{klass}")
          if ENV["VAGRANT_LOG"] == "debug"
            R10K::Logging.level = 0
            @logger.level = 0
          else
            R10K::Logging.level = 3
          end
        end

        def get_logger
          @logger
        end

      end
    end
  end
end

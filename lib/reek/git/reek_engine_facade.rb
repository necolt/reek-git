# frozen_string_literal: true

module Reek
  module Git
    class ReekEngineFacade

      def call(file_to_exam)
        Reek::Examiner.new(
          Pathname.new(file_to_exam.filename),
          configuration: configuration
        ).smells
      end

      # @api private
      def configuration
        @configuration ||= Reek::Configuration::AppConfiguration.from_path
      end
    end
  end
end

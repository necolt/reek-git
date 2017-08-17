require 'shellwords'

module Reek
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/services/build_runner.rb
    class Runner
      def run(options)
        options = Options.new(options) unless options.is_a?(Options)

        @options = options
        @files = DiffParser.parse(git_diff(options))

        display_violations($stdout)

        exit(1) if violations.any?
      end

      private

      def violations
        @violations ||= style_checker.violations
      end

      def style_checker
        StyleChecker.new(pull_request.pull_request_files)
      end

      def pull_request
        @pull_request ||= PseudoPullRequest.new(@files, @options)
      end

      def git_diff(options)
        args = %w(diff --diff-filter=AMCR --find-renames --find-copies)

        if options.cached
          args << '--cached'
        elsif options.commit_last
          args << options.commit_first.shellescape
          args << options.commit_last.shellescape
        end

        `git #{args.join(' ')}`
      end

      def display_violations(io)
        violations.each do |violation|
          io.puts(
            Reek::Report::Formatter.format_list(
              violation.offenses,
              formatter: Reek::Report::Formatter::SimpleWarningFormatter.new(
                location_formatter: Reek::Report::Formatter::SingleLineLocationFormatter
              )
            )
          )
        end
      end
    end
  end
end

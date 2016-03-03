require 'reek/git'
require 'optparse'

module Reek
  module Git
    class CLI
      def run(args = ARGV)
        @options = Options.new
        parse_arguments(args)
        Runner.new.run(@options)
      end

      private

      def parse_arguments(args)
        @options.commits = option_parser.parse(args)
      rescue OptionParser::InvalidOption, Options::Invalid => ex
        warn "ERROR: #{ex.message}"
        $stderr.puts
        warn option_parser
        exit 1
      end

      def option_parser
        @option_parser ||= OptionParser.new do |opt|
          opt.banner << ' [[commit] commit]'

          opt.on('-r', '--require FILE',
                 'Require Ruby file') do |file|
            require file
          end

          opt.on('--cached', 'git diff --cached') do
            @options.cached = true
          end

          opt.on('--staged', 'synonym of --cached') do
            @options.cached = true
          end
        end
      end
    end
  end
end

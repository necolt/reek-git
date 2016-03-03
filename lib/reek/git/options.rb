module Reek
  module Git
    class Options
      class Invalid < StandardError; end

      HOUND_DEFAULT_CONFIG_FILE =
        File.expand_path('../../../../hound.yml', __FILE__)

      attr_reader :cached

      def initialize(hash_options = nil)
        @cached  = false
        @commits = []

        from_hash(hash_options) if hash_options
      end

      def cached=(cached_)
        if cached_ && !@commits.empty?
          fail Invalid, 'cached and commit cannot be specified together'
        end
        @cached = !!cached_
      end

      def commits=(commits)
        unless commits.is_a?(Array) && commits.length <= 2
          fail Invalid, "invalid commits: #{commits.inspect}"
        end
        if !commits.empty? && cached
          fail Invalid, 'cached and commit cannot be specified together'
        end
        @commits = commits
      end

      def commit_first
        @commits.length == 1 ? @commits.first + '^' : @commits.first
      end

      def commit_last
        @commits.last
      end

      private

      def from_hash(hash_options)
        hash_options = hash_options.dup
        %w(cached commits).each do |key|
          public_send("#{key}=", hash_options.delete(key))
        end
        unless hash_options.empty?
          fail Invalid, "invalid keys: #{hash_options.keys.join(' ')}"
        end
      end
    end
  end
end

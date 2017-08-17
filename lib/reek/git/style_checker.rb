module Reek::Git
  # ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/models/style_checker.rb
  class StyleChecker
    def initialize(modified_files)
      @modified_files = modified_files
    end

    def violations
      file_violations = @modified_files.map do |modified_file|
        FileViolation.new(modified_file.filename, offenses(modified_file))
      end
      file_violations.select do |file_violation|

        file_violation.offenses.any?
      end
    end

    private

    def reek_engine
      @reek_engine ||= ReekEngineFacade.new
    end

    def offenses(modified_file)
      if File.extname(modified_file.filename) == '.rb'
        violations_on_changed_lines(
          modified_file,
          reek_engine.call(modified_file)
        )
      else
        []
      end
    end

    def violations_on_changed_lines(modified_file, violations)
      violations.select do |violation|
        violation.lines.any? do |line|
          modified_file.relevant_line?(line)
        end
      end
    end
  end
end

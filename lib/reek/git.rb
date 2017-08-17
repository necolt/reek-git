require 'reek/git/version'
require 'reek'
require 'reek/report/formatter'

module Reek
  module Git
    autoload :Commit,            'reek/git/commit'
    autoload :CommitFile,        'reek/git/commit_file'
    autoload :DiffParser,        'reek/git/diff_parser'
    autoload :FileViolation,     'reek/git/file_violation'
    autoload :Line,              'reek/git/line'
    autoload :Options,           'reek/git/options'
    autoload :Patch,             'reek/git/patch'
    autoload :PseudoPullRequest, 'reek/git/pseudo_pull_request'
    autoload :PseudoResource,    'reek/git/pseudo_resource'
    autoload :Runner,            'reek/git/runner'
    autoload :ReekEngineFacade,  'reek/git/reek_engine_facade'
    autoload :StyleChecker,      'reek/git/style_checker'
    autoload :StyleGuide,        'reek/git/style_guide'
  end
end

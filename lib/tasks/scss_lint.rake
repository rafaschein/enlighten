require 'scss_lint/rake_task'
SCSSLint::RakeTask.new

task default: :scss_lint

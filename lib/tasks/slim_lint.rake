require 'slim_lint/rake_task'
SlimLint::RakeTask.new

task default: :slim_lint

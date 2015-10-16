desc 'Run Brakeman'
task :brakeman do
  require 'brakeman'
  Brakeman.run app_path: '.', print_report: true
end

task default: :brakeman

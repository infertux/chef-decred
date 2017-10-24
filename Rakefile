namespace :style do
  desc 'Run Ruby style checks'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task 'style:all' => ['style:ruby', 'style:chef']

if ENV['DIGITALOCEAN_ACCESS_TOKEN']
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new

  task default: ['style:all', 'kitchen:all']
else
  task default: ['style:all']
end

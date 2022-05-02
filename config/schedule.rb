set :path, "/home/ubuntu/Aakrat/current"
job_type :bundle, 'cd :path && :environment_variable=:environment bundle exec :task'

every 1.day, at: '00:01 am' do
  command "logrotate /home/ubuntu/Aakrat/shared/log/logrotate.conf --state /home/ubuntu/Aakrat/shared/log/logrotate.state --verbose"
  rake "ts:rebuild"
end

every :reboot do
  bundle "sidekiq"
  rake "ts:rebuild"
  bundle "puma -C /home/ubuntu/Aakrat/shared/puma.rb"
end

# every 1.hour do
# end

set :path, "/home/ubuntu/Vishwakarma/current"
job_type :bundle, 'cd :path && :environment_variable=:environment bundle exec :task'

every 1.day, at: '00:01 am' do
  command "logrotate /home/ubuntu/Vishwakarma/shared/log/logrotate.conf --state /home/ubuntu/Vishwakarma/shared/log/logrotate.state --verbose"
  rake "ts:rebuild"
end

every :reboot do
  bundle "sidekiq"
  rake "ts:rebuild"
  bundle "puma -C /home/ubuntu/Vishwakarma/shared/puma.rb"
end

# every 1.hour do
# end

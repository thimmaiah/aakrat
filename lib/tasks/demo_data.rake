namespace :sa do
  require "faker"
  require 'digest/sha1'
  require 'factory_bot'

  
  desc "generates fake Company for testing"
  task generateFakeEntities: :environment do
    (1..10).each do 
      e = FactoryBot.create(:company, company_type: "Architect")
      puts "Company #{e.name}"
      (1..2).each do |j|
        user = FactoryBot.create(:user, company: e, first_name: "Emp#{j}")
        puts user.to_json
      end
    end

    user = FactoryBot.create(:user, company: nil, first_name: "Super", last_name: "Admin", email: "admin@altx.com")
    user.add_role(:super)
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end



  
  task :generateAll => [:generateFakeEntities] do
    puts "Generating all Fake Data"
    Sidekiq.redis(&:flushdb)
  end

end

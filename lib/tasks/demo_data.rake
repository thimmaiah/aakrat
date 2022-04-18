namespace :vk do
  require "faker"
  require 'digest/sha1'
  require 'factory_bot'

  
  desc "generates fake Company for testing"
  task generateFakeCompanies: :environment do
    (1..3).each do 
      e = FactoryBot.create(:company, company_type: "Architect")
      puts "Company #{e.name}"
      (1..2).each do |j|
        user = FactoryBot.create(:user, company: e, first_name: "Emp#{j}")
        user.add_role(:team_lead)
        puts user.to_json
      end
    end

    user = FactoryBot.create(:user, company: nil, first_name: "Super", last_name: "Admin", email: "admin@altx.com")
    user.add_role(:super)
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end



  desc "generates fake Users for testing"
  task generateFakeUsers: :environment do
    (1..10).each do 
      u = FactoryBot.create(:user)
      u.add_role([:client, :contractor][rand(2)])  
      
      puts u.to_json
    end
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end


  desc "generates fake Projects for testing"
  task generateFakeProjects: :environment do
    Company.all.each do |c| 
      (1..5).each do 
        p = FactoryBot.create(:project, company: c)        
        puts p.to_json
        (1..10).each do |i|
          s = FactoryBot.create(:phase, name: "Phase #{i}", company: c, project: p)        

          (1..10).each do |j|
            t = FactoryBot.create(:step, name: "Step #{j}", company: c, project: p, phase: s)        
          end
        end
      end
    end
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end


  
  task :generateAll => [:generateFakeCompanies, :generateFakeUsers, :generateFakeProjects] do
    puts "Generating all Fake Data"
    Sidekiq.redis(&:flushdb)
  end

end

namespace :vk do
  require "faker"
  require 'digest/sha1'
  require 'factory_bot'

  
  desc "generates fake Company for testing"
  task generateFakeCompanies: :environment do
    user_count = 1
    (1..3).each do 
      e = FactoryBot.create(:company, company_type: "Architect")
      puts "Company #{e.name}"
      (1..2).each do |j|
        user = FactoryBot.create(:user, company: e, first_name: "Emp#{user_count}", email: "emp#{user_count}@gmail.com")
        user_count += 1
        user.add_role(:team_lead)
        puts user.to_json
      end
    end

    user = FactoryBot.create(:user, company: nil, first_name: "Super", last_name: "Admin", email: "admin@aakrat.com")
    user.add_role(:super)
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end



  desc "generates fake Users for testing"
  task generateFakeUsers: :environment do
    (1..10).each do |i|
      role = [:client, :contractor][rand(2)]
      u = FactoryBot.create(:user, email: "#{role}#{i}@yahoo.com")
      u.add_role(role)        
      puts u.to_json
    end
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end


  desc "generates fake Projects for testing"
  task generateFakeProjects: :environment do
    Company.all.each do |c| 
      
      (1..3).each do
        FactoryBot.create(:client, company: c)
      end

      (1..5).each do 
        p = FactoryBot.create(:project, company: c)        
        puts p.to_json
        (1..5).each do |i|
          s = FactoryBot.create(:phase, name: "Phase #{i}", company: c, project: p)        

          (1..3).each do |j|
            t = FactoryBot.create(:step, name: "Step #{j}", company: c, project: p, phase: s)        
          end

          (1..1).each do |j|
            t = FactoryBot.create(:site_visit, company: c, project: p, phase: s)        
          end
        end
      end
    end
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end


  desc "generates fake Payments for testing"
  task generateFakePayments: :environment do
    Phase.where(payment_required: true).each do |p| 
      t = FactoryBot.create(:payment, company: p.company, project: p.project, phase: p)              
    end
  rescue Exception => e
    puts e.backtrace.join("\n")
    raise e
  end


  
  task :generateAll => [:generateFakeCompanies, :generateFakeUsers, :generateFakeProjects, :generateFakePayments] do
    puts "Generating all Fake Data"
    Sidekiq.redis(&:flushdb)
  end

end

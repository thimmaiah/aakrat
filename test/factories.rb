FactoryBot.define do
  factory :project do
    name { ["Villa Project", "Industrial Shed", "Interior Design", "Farm House", "Vacation Home", "Low cost housing"][rand(6)] }
    start_date { Time.zone.today - rand(10).days }
    end_date { Time.zone.today + rand(10).days + rand(24).months }
    cost_estimate_cents { (rand(100) + rand(100) ) * 100_000_00 }
    percentage_completed { rand(100) }
    status { Project::STATUS[rand(Project::STATUS.length)] }
    company { Company.all.sample }
    client { User.clients.sample }
    team_lead { User.team_leads.sample }
    currency { company.currency }
  end

  factory :payment do
    company { Company.all.sample }
    amount { rand(100)*10 + rand(100) * 10 }
    plan { Company::PLANS[rand(Company::PLANS.length)] }
    discount { 0 }
    reference_number { (0...8).map { (65 + rand(26)).chr }.join }
    user { company.employees.sample }
  end


  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { company ? "#{first_name.downcase}@#{company.name.parameterize}.com" : Faker::Internet.email }
    password { "password" }
    phone { Faker::PhoneNumber.cell_phone }
    confirmed_at { Time.zone.now }
    accept_terms {true}
  end

  factory :company do
    name { Faker::Company.name }
    category { Faker::Company.industry }
    url { "https://#{Faker::Internet.domain_name}" }
    company_type { Company::TYPES[rand(Company::TYPES.length)] }
    currency {"INR"}
  end
end

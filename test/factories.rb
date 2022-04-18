FactoryBot.define do
  
  factory :payment do
    company { Company.all.sample }
    amount { rand(100)*10 + rand(100) * 10 }
    plan { Company::PLANS[rand(Company::PLANS.length)] }
    discount { 0 }
    reference_number { (0...8).map { (65 + rand(26)).chr }.join }
    user { company.employees.sample }
  end


  factory :user do
    company { Company.all.sample }
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
  end
end

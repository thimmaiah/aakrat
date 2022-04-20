class Client < ApplicationRecord
  TYPES = %w[Client Accountant Contractor].freeze

  belongs_to :user
  belongs_to :company

  validates :first_name, :last_name, :email, :phone, :user_type, presence: true

  before_validation :set_user
  def set_user
    self.user = User.where(email: email).first

    unless user
      password = (0...8).map { rand(65..90).chr }.join
      self.user = User.create(first_name: first_name, last_name: last_name,
                              email: email, phone: phone, system_created: true,
                              active: true, password: password)

    end

    # Add the right role
    case user_type
    when "Client"
      user.add_role(:client)
    when "Contractor"
      user.add_role(:contractor)
    when "Accountant"
      user.add_role(:accountant)
    end

    self.phone = user.phone
  end
end

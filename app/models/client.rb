class Client < ApplicationRecord
  belongs_to :user
  belongs_to :company

  before_validation :set_user
  def set_user
    self.user = User.where(email: email).first

    unless user
      password = (0...8).map { rand(65..90).chr }.join
      self.user = User.create(first_name: first_name, last_name: last_name,
                              email: email, phone: phone, system_created: true,
                              active: true, password: password)
    end

    self.phone = user.phone
  end
end

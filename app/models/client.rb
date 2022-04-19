class Client < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :company

  before_save :set_user
  def set_user
    self.user = User.where(email: email).first
    self.phone = user.phone if user
  end
end

class User < ApplicationRecord
  # Make all models searchable
  ThinkingSphinx::Callbacks.append(self, behaviours: [:real_time])

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Only if this user is an employee of the company
  belongs_to :company, optional: true

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }, presence: true

  # "CxO", "Founder", "Angel", "VC", "Admin",
  ROLES = ["Customer", "Team Lead", "Team Member", "Contractor", "Company Admin"].freeze

  scope :admins, -> { where(role: "Company Admin") }
  scope :customers, -> { where(role: "Customer") }
  scope :contractors, -> { where(role: "Contractor") }
  scope :team_leads, -> { where(role: "Team Lead") }
  scope :team_members, -> { where(role: "Team Member") }

  before_create :setup_defaults

  def to_s
    full_name
  end

  def name
    full_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def setup_defaults
    add_role :team_member
    # add_role :investor if (company && company.company_type == "VC") || InvestorAccess.where(user_id: id).first.present?
    # add_role :secondary_buyer if company && ["Advisor", "Family Office", "VC"].include?(company.company_type)
    # add_role :startup if company && (company.company_type == "Startup")
    self.active = true
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def active_for_authentication?
    active && !confirmed_at.nil?
  end

  def reset_password?
    sign_in_count == 1 && system_created
  end
end

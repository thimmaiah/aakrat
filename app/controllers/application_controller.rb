class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include PublicActivity::StoreController

  skip_before_action :verify_authenticity_token if ENV['SKIP_AUTHENTICITY_TOKEN'] == "true"

  after_action :verify_authorized, except: %i[index search], unless: :devise_controller?
  after_action :verify_policy_scoped, only: [:index]

  before_action :authenticate_user!
  before_action :set_search_controller
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  # skip_before_action :verify_authenticity_token, if: lambda { ENV["skip_authenticity_token"].present? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone role company_id])
  end

  def set_search_controller
    @search_controller = params[:controller] == "home" ? "companies" : params[:controller]
  end

  rescue_from Pundit::NotAuthorizedError do |_exception|
    redirect_to dashboard_companies_path, alert: "Access Denied"
  end

  before_action :prepare_exception_notifier

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      current_user:
    }
  end

  def after_sign_out_path_for(_resource_or_scope)
    cookies.delete(:scenario_id, domain: :all) if cookies[:scenario_id]
    request.referer
  end
end

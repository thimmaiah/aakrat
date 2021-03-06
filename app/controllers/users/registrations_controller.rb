module Users
  class RegistrationsController < Devise::RegistrationsController
    prepend_before_action :require_no_authentication, only: %i[new cancel]

    # POST /resource
    def create
      build_resource(sign_up_params)
      # Ensure role is always Employee
      resource.add_role :employee
      ensure_company(resource)
      resource.save

      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    protected

    def after_sign_up_path_for(resource)
      if current_user
        dashboard_companies_path
      elsif is_navigational_format?
        after_sign_in_path_for(resource)
      end
    end

    def after_inactive_sign_up_path_for(_resource)
      welcome_users_path
    end

    def ensure_company(resource)
      # Ensure that users are created only for the same company as the logged in user.
      if current_user && !current_user.has_role?(:super)
        resource.company_id = current_user.company_id
        logger.debug "Setting new user company to logged in users company #{current_user.company_id}"
      end
    end
  end
end

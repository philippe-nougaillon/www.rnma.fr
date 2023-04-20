class ApplicationController < ActionController::Base
    include Pundit::Authorization
    
    before_action :authenticate_user!
    before_action :detect_device_format
    before_action :prepare_exception_notifier
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :store_current_location, unless: :devise_controller?

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    # after_action :verify_authorized
    

protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:nom, :prénom, :email, :password, :password_confirmation, :maison_id)}
    end

private

    def detect_device_format
        case request.user_agent
        when /iPhone/i, /Android/i && /mobile/i, /Windows Phone/i
            request.variant = :phone
        else
            request.variant = :desktop
        end
    end

    def prepare_exception_notifier
        request.env["exception_notifier.exception_data"] = {
            current_user: current_user
        }
    end

    def user_not_authorized
        flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action. Veuillez vous connecter."
        redirect_back(fallback_location: new_user_session_path)
    end

    def store_current_location
        if request.url != root_url
            store_location_for(:user, request.url)
        end
    end
    
    def after_sign_in_path_for(resource)
        stored_location_for(resource) || membres_index_path
    end

end

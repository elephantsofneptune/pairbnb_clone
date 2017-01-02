class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :owner?, :moderator?, :superadmin?, :d

    protected

    def owner?
        if current_user.id == params[:id].to_i || moderator?
            true
        else
            flash[:error] = "This is not yours"
            redirect_to root_path
        end
    end

    def moderator?
        if current_user.role == "moderator" || superadmin?
            true
        else
            false
        end
    end

    def superadmin?
        if current_user.role == "superadmin"
            true
        else
            false
        end
    end
    
    def d
        self.strftime('%v')
    end
end

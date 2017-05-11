module APIAuthentication
  extend ActiveSupport::Concern

  included do
    def authenticate
      if user = User.authenticate(request.headers['X-AUTH-TOKEN'])
        sign_in(user, store: false)
        authenticate_user!
      end
    end


    def authenticate!
      authenticate
      render_401('you need to be logged in') unless current_user
    end
  end

end

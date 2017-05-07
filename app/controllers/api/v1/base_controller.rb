class API::V1::BaseController < API::BaseController
  include JSONErrors


  def index
    render json: { active: true }
  end


  def authenticate!
    if user = User.authenticate(request.headers['X-AUTH-TOKEN'])
      sign_in(user, store: false)
      authenticate_user!
    else
      render_401
    end
  end

end

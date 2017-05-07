class API::V1::BaseController < API::BaseController
  include JSONErrors

  skip_before_action :verify_authenticity_token


  def index
    render json: { active: true }
  end


  def authenticate
    if user = User.authenticate(request.headers['X-AUTH-TOKEN'])
      sign_in(user, store: false)
      authenticate_user!
    end
  end


  def authenticate!
    authenticate
    render_401 unless current_user
  end

end

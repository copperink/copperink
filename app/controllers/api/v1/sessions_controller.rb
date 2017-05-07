class API::V1::SessionsController < API::V1::BaseController
  before_action :authenticate, only: :index


  def index
    status = (current_user ? 'valid' : 'invalid')
    render json: { session: status }
  end


  def signin
    user = User.find_for_authentication(email: session_params[:email])

    if user && user.valid_password?(session_params[:password])
      render json: { auth_token: user.authentication_token }
    else
      render_401('incorrect email or password')
    end
  end


  def signup
    user = User.new(session_params)

    if user.save
      render json: { auth_token: user.authentication_token }
    else
      render_object_errors(user)
    end
  end



  private

  def session_params
    params.require(:user).permit(:name, :email, :password)
  end

end

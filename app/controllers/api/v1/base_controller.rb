class API::V1::BaseController < API::BaseController
  include JSONErrors
  include APIAuthentication

  skip_before_action :verify_authenticity_token


  def index
    render json: { active: true }
  end

end

class API::V1::BaseController < API::BaseController
	rescue_from Exception, with: :render_server_error

  def index
    render json: { active: true }
  end


  private

  def render_server_error(error)
    render json: { error: error.message }, status: 500
  end

end

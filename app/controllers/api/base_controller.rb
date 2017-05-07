class API::BaseController < ApplicationController
  respond_to :json

  def index
    render json: { api: 'v1' }
  end

end

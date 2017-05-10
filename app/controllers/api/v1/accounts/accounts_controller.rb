class API::V1::Accounts::AccountsController < API::V1::BaseController
  before_action :authenticate!

  def index
    render json: { accounts: current_user.accounts.map(&:to_h) }
  end
end

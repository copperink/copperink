class API::V1::Accounts::FacebookController < API::V1::BaseController
  before_action :authenticate!


  # Returns a JSON object containing a list of
  # facebook accounts that can be added for a
  # given facebook access token
  def list
    token = SocialService::Facebook.renew_token(token_params)

    accounts =
      SocialService::Facebook
        .accounts(token)
        .reject { |a| a[:id].in?(facebook_account_ids) }

    render json: { accounts: accounts }
  end



  # Saves passed account objects to DB
  def save
    Account.create!(account_params.map do |data|
      {
        type: :facebook,
        user: current_user,
        name: data[:name],
        data: data
      }
    end)

    render json: {}
  end



  private

  def token_params
    params.require(:facebook).require(:token)
  end

  def account_params
    params
      .permit(accounts: [:id, :name, :image, :token, :type])
      .require(:accounts)
      .map(&:to_h)
      .map(&:symbolize_keys)
  end


  # IDs of current user's facebook accounts
  def facebook_account_ids
    @facebook_account_ids ||=
      current_user
        .accounts
        .where(type: :facebook)
        .map { |a| a.data[:id] }
  end

end

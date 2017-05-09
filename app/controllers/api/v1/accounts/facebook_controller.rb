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



  private

  def token_params
    params.require(:facebook).require(:token)
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

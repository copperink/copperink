class SocialService::Facebook
  TYPE            = :facebook
  POST_PERMISSION = 'CREATE_CONTENT'.freeze
  PICTURE_FIELD   = 'picture.type(large){url}'.freeze
  ACCOUNT_FIELDS  = %W(id name #{PICTURE_FIELD} accounts{access_token,name,perms,#{PICTURE_FIELD}}).freeze
  ACCOUNT_TYPES   = %w(profile, :page).freeze


  # TODO: Validate tokens for required permissions


  # Gets the Profile and 'Postable' Pages for a User Token
  def self.accounts(token)
    data = graph(token).get_object('me', fields: ACCOUNT_FIELDS)
    data['access_token'] = token

    accounts =
      data['accounts']['data']
        .select { |a| a['perms'].include?(POST_PERMISSION) }
        .map    { |a| normalize_account_data(a, 'page')    }

    accounts.unshift(normalize_account_data(data))
  end


  # Get Token Details
  def self.token_details(token)
    graph(token)
      .get_object('debug_token', input_token: token)['data']
      .deep_symbolize_keys
  end


  # New Graph Object for token
  def self.graph(token)
    Koala::Facebook::API.new(token)
  end


  # Renews a Facebook Token
  def self.renew_token(token)
    Koala::Facebook::OAuth.new.exchange_access_token(token)
  end


  # Post a Status to Facebook
  def self.post_status(account, status)
    graph(account.data[:token]).put_wall_post(status)
  end


  # Post an Image to Facebook
  def self.post_image(account, image, status = nil)
    client = graph(account.data[:token])

    if image.is_a?(ImageAttachment)
      client.put_picture(image.data.path, image.data.content_type, caption: status)
    else
      client.put_picture(image, caption: status)
    end
  end



  private

  def self.normalize_account_data(data, type = 'profile')
    {
      id:     data['id'],
      name:   data['name'],
      image:  data['picture']['data']['url'],
      token:  data['access_token'],
      type:   type
    }
  end
end

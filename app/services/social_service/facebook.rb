class SocialService::Facebook < SocialService::Base
  POST_PERMISSION = 'CREATE_CONTENT'.freeze
  PICTURE_FIELD   = 'picture.type(large){url}'.freeze
  ACCOUNT_FIELDS  = %W(id name #{PICTURE_FIELD} accounts{access_token,name,perms,#{PICTURE_FIELD}}).freeze
  ACCOUNT_TYPES   = %w(profile, :page).freeze


  def self.to_sym;   :facebook;   end


  def self.accounts(token)
    data =
      Koala::Facebook::API
        .new(token)
        .get_object('me', fields: ACCOUNT_FIELDS)

    accounts =
      data['accounts']['data']
        .select { |a| a['perms'].include?(POST_PERMISSION) }
        .map    { |a| normalize_account_data(a, 'page')    }

    accounts.unshift(normalize_account_data(data))
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

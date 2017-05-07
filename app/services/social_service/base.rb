class SocialService::Base
  def self.to_sym
    fail NotImplementedError
  end
end

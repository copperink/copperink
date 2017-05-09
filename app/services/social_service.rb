class SocialService
  ALLOWED = [
    SocialService::Facebook
  ].freeze


  def self.types
    @types ||=
      ALLOWED.map { |ss| ss::TYPE }
  end

end

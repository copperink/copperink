class SocialService
  ALLOWED = [
    SocialService::Facebook
  ].freeze


  def initialize(account)
    @account = account
    @type    = account.type
    @service = SocialService.find(@type)
  end


  def post_status(status)
    @service.post_status(@account, status)
  end


  def post_image(image, status = nil)
    @service.post_image(@account, image, status)
  end


  def inspect
    "#<#{self.class}:#{object_id} - #{@type.to_s.capitalize} (#{@account.name})>"
  end



  # Class Methods

  def self.types
    @types ||= ALLOWED.map { |ss| ss::TYPE }
  end


  def self.find(type)
    ALLOWED.find { |ss| ss::TYPE == type.to_sym }
  end

end

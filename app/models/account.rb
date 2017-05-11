class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :name,   type: String
  field :type,   type: Symbol
  field :data,   type: Hash,   default: {}

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: SocialService.types }


  def image_url
    self.data[:image]
  end


  def to_h
    {
      id:     self.id.to_s,
      name:   self.name,
      type:   self.type.to_s,
      image:  self.image_url
    }
  end

end

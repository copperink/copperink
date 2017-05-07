class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :name, type: String
  field :type, type: Symbol
  field :data, type: Hash,   default: {}

  validates :name, presence: true
  validates :type, presence: true, inclusion: { in: SocialService.types }
end

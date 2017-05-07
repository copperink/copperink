class Account
  include Mongoid::Document

  belongs_to :user

  field :name, type: String
  field :type, type: String
  field :data, type: Hash,  default: {}

  validates :name, presence: true
  validates :type, presence: true
end

class SocialAccount
  include Mongoid::Document
  field :name, type: String
  field :key, type: String
end
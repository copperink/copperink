class Post
  include Mongoid::Document
  field :content, type: Text
  field :author, type: User
  field :post_at, type: DateTime
end

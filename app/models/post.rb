class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include HasOneImage

  STATUSES = %i(queued posted error)

  belongs_to :account
  belongs_to :author, class_name: 'User'

  field :status,    type: Symbol,   default: :queued
  field :content,   type: String
  field :post_at,   type: DateTime

  validates :status,  presence: true, inclusion:  { in:    STATUSES     }
  validates :post_at, presence: true, timeliness: { after: DateTime.now }


  def to_h
    {
      id:         self.id.to_s,
      content:    self.content,
      post_at:    self.post_at.to_i,
      status:     self.status.to_s,
      author_id:  self.author_id.to_s,
      account_id: self.account_id.to_s,
      image:      self.image_url
    }
  end


  def post!
    raise "Already Posted" if self.status == :posted

    begin
      SocialService
        .new(self.account)
        .post_status(self.content)

      update(status: :posted)

    rescue Koala::Facebook::ClientError => e
      logger.error(e)
      update(status: :error)
    end
  end

end

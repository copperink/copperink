class SocialWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, backtrace: true

  def perform(post_id)
    Post.find(post_id).post!
  end

end

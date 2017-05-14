class SocialWorker
  include Sidekiq::Worker

  sidekiq_options retry: false, backtrace: true

  def perform(post_id)
    puts "\n---------------------"
    puts "Running SocialWorker "
    puts "Posting for id: #{post_id}"
    puts "---------------------\n\n"

    Post.find(post_id).post!
  end

end

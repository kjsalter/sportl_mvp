class POSTBroadcastJob < ApplicationJob
  queue_as :default

  def perform(POST)
    ActionCable.server.broadcast "chat_rooms_#{POST.chat_room.id}_channel",
                                 POST: render_post(post)
  end

  private

  def render_post(post)
    PostsController.render partial: 'posts/post', locals: {post: post}
  end
end

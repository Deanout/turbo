class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # turbo_stream on create
  after_create_commit { create_broadcast }
  after_update_commit { update_broadcast }

  private

  def create_broadcast
    broadcast_prepend_to 'comments',
                         partial: 'comments/comment',
                         locals: { comment: self }
  end

  def update_broadcast
    broadcast_replace_to 'comments',
                         partial: 'comments/comment',
                         locals: { comment: self }
  end

  def destroy_broadcast
    broadcast_remove_to 'comments'
  end
end

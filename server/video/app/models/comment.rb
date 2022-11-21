class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # broadcasts_to ->(comment) { 'comments' }

  after_create_commit { create_broadcast }
  after_update_commit { update_broadcast }
  after_destroy_commit { destroy_broadcast }

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

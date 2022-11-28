class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_to_room }
  after_destroy_commit { broadcast_remove_to_room }

  private

  def broadcast_to_room
    room_name = "room_#{room.id}"
    # Broadcast to users the normal div
    broadcast_prepend_to room_name,
                         target: 'messages',
                         partial: 'messages/message',
                         locals: { message: self, admin: false }

    # Broadcast to message creator stream
    broadcast_append_to "#{user&.to_gid_param}",
                        target: "controls_message_#{id}",
                        partial: 'messages/user_controls',
                        locals: { message: self, user: }

    broadcast_append_to ['admin', room_name],
                        target: "controls_message_#{id}",
                        partial: 'messages/admin_controls',
                        locals: { message: self }

    # then broadcast to admins
  end

  def broadcast_remove_to_room
    room_name = "room_#{room.id}"
    broadcast_remove_to room_name,
                        target: "message_#{
                          id
                        }"
  end
end

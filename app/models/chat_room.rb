class ChatRoom < ApplicationRecord
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'recipient_id'
  has_many :posts, dependent: :destroy
  validates_uniqueness_of :sender_id, :scope => :recipient_id


  def find_conversation!
    sender_events = self.sender.events #events sender owns
    sender_bookings = self.sender.bookings #events sender has booked on to
    recipient_events = self.recipient.events #events recipient owns
    recipient_bookings = self.recipient.bookings #events recipient has booked on to

  end




end

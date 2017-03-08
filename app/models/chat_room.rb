class ChatRoom < ApplicationRecord
  belongs_to :sender, :class_name => 'User', :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => 'User', :foreign_key => 'recipient_id'
  has_many :posts, dependent: :destroy
  validates_uniqueness_of :sender_id, :scope => :recipient_id


  def find_conversation
    sender_events = self.sender.events #events sender owns
    recipient_bookings = []
    self.recipient.bookings.each { |booking| recipient_bookings << booking.event } #events recipient has booked on to
    matching_se_rb = sender_events & recipient_bookings #events that sender owns & recipient has booked on to


    recipient_events = self.recipient.events #events recipient owns
    sender_bookings = []  #events sender has booked on to
    self.sender.bookings.each { |booking| sender_bookings << booking.event }
    matching_re_sb = recipient_events & sender_bookings #events that recipient owns & sender has booked on to

    all_pairs = matching_se_rb + matching_re_sb #both options!
    all_active_pairs = all_pairs.select {|event| event.start_time > Time.now } #event active
    return all_active_pairs.min_by { |event| event.start_time } #closest event
  end

end

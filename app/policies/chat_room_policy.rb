class ChatRoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
    scope.where "#{user.id} = sender_id OR #{user.id} = recipient_id"
    end
  end

  def index?
    record.sender_id == user.id || record.recipient_id == user.id
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end
end

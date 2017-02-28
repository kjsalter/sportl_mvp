class ConversationPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.where "#{user.id} = sender_id OR #{user.id} = recipient_id"
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index?
    record.sender_id == user.id || record.recipient_id == user.id
  end

  # [...]

  def create?
    return true
  end
end

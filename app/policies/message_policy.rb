class MessagePolicy < ApplicationPolicy
  # [...]

  class Scope < Scope
    def resolve
      scope.all
      # For a multi-tenant SaaS app, you may want to use:
      # scope.where(user: user)
    end
  end

  def index?
    return true
  end

  def new?
    return true
  end

  def create?
    return true
  end
end

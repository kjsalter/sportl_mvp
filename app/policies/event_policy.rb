class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true  # Anyone can view a event
  end

  def create?
    true  # Anyone can create a event
  end

  def update?
    record.user == user  # Only event creator can update it
  end

  def destroy?
    record.user == user  # Only event creator can update it
  end
end

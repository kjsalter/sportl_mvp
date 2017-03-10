class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    true
  end

  def show?
    record.user == user || record.event.user # Only booking creator can view it
  end

  def update?
    true
  end

  def pending?
    user == record.user
  end
end

class ShipmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.donor?
        scope.where(user: user)
      else
        scope.all
      end
    end
  end

  def create?
    user.aidpioneer?
  end

  def update?
    user.aidpioneer?
  end

  def show?
    user.aidpioneer?
  end

  def qr?
    user.aidpioneer?
  end
end

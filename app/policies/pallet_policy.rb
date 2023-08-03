class PalletPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def create?
    user.aidpioneer?
  end

  def update?
    user.aidpioneer?
  end

  def destroy?
    user.aidpioneer?
  end

  def qr?
    user.aidpioneer?
  end
end

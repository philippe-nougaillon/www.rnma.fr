class AdminPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def memo?
    index?
  end

  def send_weekly_test?
    index?
  end

  def admin_lettre_hebdo?
    index?
  end

  def send_lettre_hebdo?
    index?
  end
end

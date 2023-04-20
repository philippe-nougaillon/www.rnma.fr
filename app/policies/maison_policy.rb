class MaisonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def show?
    index?
  end

  def create?
    index?
  end

  def new?
    create?
  end

  def edit?
    index? || record.contacts.find_by(email: @user.email)
  end

  def update?
    edit?
  end

  def destroy?
    index?
  end
end

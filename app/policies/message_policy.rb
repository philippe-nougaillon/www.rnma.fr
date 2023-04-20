class MessagePolicy < ApplicationPolicy
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
    true
  end

  def new?
    true
  end

  def update?
    index?
  end

  def edit?
    update?
  end

  def destroy?
    index?
  end

  def traiter?
    index?
  end

  def archiver?
    index?
  end
end

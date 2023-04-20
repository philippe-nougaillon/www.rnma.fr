class AdhesionPolicy < ApplicationPolicy
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

  def update?
    index?
  end

  def edit?
    update?
  end

  def destroy?
    index?
  end

  def complet?
    index?
  end

  def valider?
    index?
  end

  def resilier?
    index?
  end

  def archiver?
    index?
  end

  def renouveler?
    index?
  end
end

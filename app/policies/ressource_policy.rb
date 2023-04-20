class RessourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def show?
    !record.membres || (record.membres && @user)
  end

  def create?
    @user
  end

  def new?
    create?
  end

  def edit?
    index? || ( record.workflow_state == "brouillon" && record.audits.first.user.id == @user.id)
  end

  def update?
    edit?
  end

  def destroy?
    index?
  end

  def valider?
    index?
  end

  def publier?
    index?
  end

  def partager?
    index?
  end

  def promouvoir?
    index?
  end

  def archiver?
    index?
  end
end

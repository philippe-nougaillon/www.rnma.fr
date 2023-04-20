class PostPolicy < ApplicationPolicy
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

  def new?
    @user
  end

  def create?
    new?
  end

  def edit?
    index? || ( record.workflow_state == "nouveau" && record.audits.first.user.id == @user.id)
  end

  def update?
    edit?
  end

  def destroy?
    index?
  end

  def delete_vignette_attachment?
    index?
  end

  def delete_poster_attachment?
    index?
  end

  def publier?
    index?
  end

  def promouvoir?
    index?
  end

  def archiver?
    index?
  end
end

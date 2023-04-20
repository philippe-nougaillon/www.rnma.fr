class EvenementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def show?
    record.publique || (@user && record.membres) || (@user && @user.admin?)
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

  def delete_image_attachment?
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

  def duplicate?
    index?
  end
end

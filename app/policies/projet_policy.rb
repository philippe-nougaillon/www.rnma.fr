class ProjetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    @user.admin?
  end

  def show?
    true
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

  def delete_photo_attachment?
    index?
  end

  def delete_document_attachment?
    index?
  end

  def publier?
    index?
  end

  def archiver?
    index?
  end
end

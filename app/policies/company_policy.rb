class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_cached_role?(:super)
        scope.all
      else
        scope.where(id: user.company_id)
      end
    end
  end

  def index?
    true
  end

  def dashboard?
    true
  end

  def search?
    true
  end

  def show?
    if user.has_cached_role?(:super) || user.company_id == record.id
      true
    else
      user.company_id != record.id
    end
  end

  def create?
    user.has_cached_role?(:super)
  end

  def new?
    update?
  end

  def update?
    user.has_cached_role?(:super) || user.company_id == record.id
  end

  def edit?
    update?
  end

  def destroy?
    false
  end
end

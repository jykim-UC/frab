class ConferencePolicy < ApplicationPolicy
  # i.e.: event feedback, confernce index
  def index?
    user.is_admin? || user.is_crew?
  end

  def lookup?
    manage? || (user.person && record.events.joins(:people).where(people: { id: user.person.id }).exists?)
  end

  def read?
    return false unless user
    user.is_admin? || user.is_crew_of?(record)
  end

  def orga?
    return false unless user
    return (user.is_admin? || user.any_crew?('orga')) if record.is_a?(Class)
    user.is_admin? || user.is_orga_of?(record)
  end

  def manage?
    return false unless user
    return (user.is_admin? || user.any_crew?('orga', 'coordinator')) if record.is_a?(Class)
    user.is_admin? || user.is_manager_of?(record)
  end

  def show?
    return false unless scope.where(id: record.id).exists?
    user.is_admin? || user.is_crew_of?(record)
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def destroy?
    return false unless user
    user&.is_admin?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end

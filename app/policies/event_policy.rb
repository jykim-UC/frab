class EventPolicy < ApplicationPolicy
  def show?
    user.is_admin? || user.is_crew_of?(record.conference) || (user.person && record.people.include?(user.person))
  end

  alias people? show?

  def edit?
    user.is_admin? || user.is_manager_of?(record.conference)
  end

  # 수정: 이벤트 소속된 사람도 update 허용
  def update?
    edit? || (user.person && record.people.include?(user.person))
  end

  alias create? edit?
  alias custom_notification? edit?
  alias destroy? edit?
  alias update_state? edit?
  alias translations? edit?
  alias edit_people? update?

  class Scope < Scope
    def resolve
      scope
    end
  end
end
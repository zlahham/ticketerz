module Admin::ApplicationHelper
  def roles
    Role.available_roles.each_with_object({}) { |role, agg| agg[role.titleize] = role }
  end
end

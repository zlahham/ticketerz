module ApplicationHelper
  def title(*parts)
    return if parts.empty?
    content_for :title do
      (parts << 'TicketerZ').join(' - ')
    end
  end

  def admins_only
    yield if current_user.try(:admin?)
  end

  def admin_status
    current_user.admin? ? "Signed in as #{current_user.email} (Admin)" : "Signed in as #{current_user.email}"
  end
end

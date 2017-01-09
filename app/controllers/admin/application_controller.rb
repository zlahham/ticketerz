class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!

  def index; end

  private

  def authorize_admin!
    authenticate_user!
    redirect_to root_path, alert: 'You must be an admin to do that.' unless current_user.admin?
  end
end

require 'rails_helper'

feature 'An admin can archive users' do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }

  before { login_as(admin) }

  scenario 'successfully' do
    visit admin_users_path(user)
    click_link 'Archive User'

    expect(page).not_to have_content object
  end
end

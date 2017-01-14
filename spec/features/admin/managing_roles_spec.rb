require 'rails_helper'

feature 'Admins can manage user roles' do
  let!(:project1) { create(:project) }
  let!(:project2) { create(:project, name: 'Sublime') }
  let(:user)     { create(:user) }
  let(:admin)    { create(:user, :admin) }

  before { login_as(admin) }

  scenario 'when assigning roles to a user' do
    visit admin_user_path(user)
    click_link 'Edit User'

    select 'Viewer', from: 'Atom'
    select 'Manager', from: 'Sublime'

    click_button 'Update User'
    expect(page).to have_content 'User has been updated'

    click_link user.email
    expect(page).to have_content 'Atom: Viewer'
    expect(page).to have_content 'Sublime: Manager'
  end
end

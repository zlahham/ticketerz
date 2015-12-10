require 'rails_helper'

feature 'Admins can edit a users details' do
  let(:admin) { create(:user, :admin) }
  let(:user)  { create(:user) }

  before do
    login_as(admin)
    visit admin_user_path(user)
    click_link 'Edit User'
  end

  scenario 'with valid details' do
    fill_in 'Email', with: 'newname@example.com'
    click_button 'Update User'

    expect(page).to have_content 'User has been updated.'
    expect(page).to have_content 'newname@example.com'
    expect(page).not_to have_content user.email
  end

  scenario 'but not with invalid details' do
    fill_in 'Email', with: ''
    click_button 'Update User'
    expect(page).to have_content 'User has not been updated.'
  end

  scenario 'when toggling admin rights' do
    check 'Is an admin?'
    click_button 'Update User'
    expect(page).to have_content 'User has been updated.'
    expect(page).to have_content "#{user.email} (Admin)"
  end
end

require 'rails_helper'

feature 'Admins can create' do
  let(:admin) { create(:user, :admin) }

  before do
    login_as admin
    visit root_path
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  context 'regular users' do
    scenario 'with valid credentials' do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Create User'
      expect(page).to have_content 'User has been created.'
      expect(page).to have_content 'user@example.com'
    end
  end

  context 'admin users' do
    scenario 'with valid credentials' do
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Password', with: 'password'
      check 'Is an admin?'
      click_button 'Create User'
      expect(page).to have_content 'User has been created.'
      expect(page).to have_content 'admin@example.com (Admin)'
    end
  end
end

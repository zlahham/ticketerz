require 'rails_helper'

feature 'Users can sign out' do
  let!(:user) { create(:user) }
  before { login_as(user) }

  scenario 'when signed in' do
    visit root_path
    click_link 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
  end
end

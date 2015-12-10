require 'rails_helper'

feature 'Users that are signed up can sign in' do
  let(:user) { create(:user) }

  scenario 'when providing valid details' do
    visit root_path
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'user_password', with: 'password'
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content "Signed in as #{user.email}"
  end
end

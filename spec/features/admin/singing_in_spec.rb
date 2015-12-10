require 'rails_helper'

feature 'Admins that are signed up can sign in' do
  let(:admin) { create(:user, :admin) }

  before { login_as admin }

  scenario 'when providing valid details' do
    visit root_path
    expect(page).to have_content "Signed in as #{admin.email} (Admin)"
  end
end

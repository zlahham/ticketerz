require 'rails_helper'

feature 'Users can edit projects' do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
    visit root_path
    click_link 'Atom'
    click_link 'Edit Project'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Atom 2'
    click_button 'Update Project'
    expect(page).to have_content 'Project has been updated.'
    expect(page).to have_content 'Atom 2'
  end

  scenario 'but not with invalid attributes' do
    fill_in 'Name', with: ''
    click_button 'Update Project'
    expect(page).to have_content 'Project has not been updated.'
  end
end

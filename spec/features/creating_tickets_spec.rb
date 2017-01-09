require 'rails_helper'

feature 'Users can create a new ticket' do
  let(:user)    { create(:user) }
  let(:project) { create(:project, name: 'Chrome') }

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Non-standard compliance'
    fill_in 'Description', with: 'Ugly mofo pages'
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has been created.'
    within('#ticket') do
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario 'unless providing invalid attributes' do
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'unless provinding an invalid description' do
    fill_in 'Name', with: 'Some name'
    fill_in 'Description', with: 'Horrible'
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content 'Description is too short'
  end
end

require "rails_helper"

RSpec.feature 'Users can create a new ticket' do
  before do
    project = FactoryGirl.create(:project, name: 'Chrome')
    visit project_path(project)
    click_link 'New Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Non-standard compliance'
    fill_in 'Description', with: 'Ugly mofo pages'
    click_button 'Create Ticket'

    expect(page).to have_content 'Ticket has been created.'
  end

  scenario 'with non-valid attributes' do
    click_button 'Create Ticket'
    expect(page).to have_content 'Ticket has not been created.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

end

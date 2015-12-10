require 'rails_helper'

feature 'Users can edit tickets' do
  let(:author) { create(:user) }
  let(:project) { create(:project) }
  let(:ticket) { create(:ticket, project: project, author: author) }

  before do
    visit project_ticket_path(project, ticket)
    click_link 'Edit Ticket'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Make it fun!'
    click_button 'Update Ticket'
    expect(page).to have_content 'Ticket has been updated.'
    within("#ticket h2") do
      expect(page).to have_content 'Make it fun!'
      expect(page).not_to have_content ticket.name
    end
  end

  scenario 'but not with invalid attributes' do
    fill_in "Name", with: ""
    click_button 'Update Ticket'
    expect(page).to have_content 'Ticket has not been updated.'
  end
end

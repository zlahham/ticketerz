require 'rails_helper'

RSpec.feature 'Users can delete their tickets' do
  let(:author) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, author: author) }

  before { visit project_ticket_path(project, ticket) }

  scenario 'successfully' do
    click_link 'Delete Ticket'
    expect(page).to have_content 'Ticket has been deleted.'
    expect(page.current_url).to eq project_url(project)
  end
end

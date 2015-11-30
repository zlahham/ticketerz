require "rails_helper"

RSpec.feature 'Users can delete projects' do
  scenario 'with flying colours' do
    FactoryGirl.create(:project, name: 'Atom')
    visit root_path
    click_link 'Atom'
    click_link 'Delete Project'
    expect(page).to have_content 'Project has been deleted.'
    expect(page.current_url).to eq projects_url
    expect(page).not_to have_content 'Atom'
  end
end

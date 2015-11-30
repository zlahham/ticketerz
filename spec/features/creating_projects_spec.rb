require 'rails_helper'

RSpec.feature 'Users can create new projects' do
  scenario 'with valid attributes' do
    visit '/'
    click_link 'New Project'
    fill_in 'Name', with: 'Atom'
    fill_in 'Description', with: 'A text editor for everyone'
    click_button 'Create Project'
    expect(page).to have_content 'Project has been successfully created'

    project = Project.find_by(name: 'Atom')
    expect(page.current_url).to eq project_url(project)

    title = 'Atom - Projects'
    expect(page).to have_title title
  end
end

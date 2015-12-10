require 'rails_helper'

feature 'Admins can create new projects' do

  before do
    login_as( create(:user, :admin) )
    visit root_path
    click_link 'New Project'
  end

  scenario 'with valid attributes' do
    fill_in 'Name', with: 'Atom'
    fill_in 'Description', with: 'A text editor for everyone'
    click_button 'Create Project'
    expect(page).to have_content 'Project has been successfully created'
    project = Project.find_by(name: 'Atom')
    expect(page.current_url).to eq project_url(project)
    title = 'Atom - Projects'
    expect(page).to have_title title
  end

  scenario 'when providing invalid attributes' do
    click_button 'Create Project'

    expect(page).to have_content 'Project has not been created'
    expect(page).to have_content "Name can't be blank"
  end
end

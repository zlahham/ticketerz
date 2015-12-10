require "rails_helper"

feature 'Admins can delete projects' do
  before do
    login_as( create(:user, :admin) )
  end

  scenario 'with success' do
    create(:project, name: 'Atom')
    visit root_path
    click_link 'Atom'
    click_link 'Delete Project'
    expect(page).to have_content 'Project has been deleted.'
    expect(page.current_url).to eq projects_url
    expect(page).not_to have_content 'Atom'
  end
end

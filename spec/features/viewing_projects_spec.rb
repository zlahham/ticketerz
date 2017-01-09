require 'rails_helper'

feature 'Users can view all projects' do
  let(:user)      { create(:user) }
  let(:project)   { create(:project, name: 'Atom') }
  let!(:project2) { create(:project, name: 'Sublime') }

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
    visit root_path
  end

  scenario 'with the project details' do
    click_link 'Atom'
    expect(page.current_url).to eq project_url(project)
  end

  scenario 'unless they do not have permission' do
    expect(page).not_to have_content(project2.name)
  end
end

require 'rails_helper'

feature 'Users can view all projects' do
  let(:user)    { create(:user) }
  let(:project) { create(:project, name: 'Atom') }

  before do
    login_as(user)
    assign_role!(user, :viewer, project)
  end

  scenario 'with the project details' do
    visit root_path
    click_link 'Atom'
    expect(page.current_url).to eq project_url(project)
  end
end

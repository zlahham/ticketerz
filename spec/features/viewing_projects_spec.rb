require 'rails_helper'

RSpec.feature 'Users can view all projects' do
  scenario 'with the project details' do
    project = FactoryGirl.create(:project, name: 'Atom')

    visit root_path
    click_link 'Atom'
    expect(page.current_url).to eq project_url(project)
  end
end

require 'rails_helper'

feature 'Users can only see the apropriate links' do
  let(:project) { create(:project) }
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  context 'anonymous user' do
    scenario 'cannot see the New Project link' do
      visit root_path
      expect(page).not_to have_content 'New Project'
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_content 'Delete Project'
    end
  end

  context 'regular user' do
    before { login_as user }

    scenario 'cannot see the New Project link' do
      visit root_path
      expect(page).not_to have_content 'New Project'
    end

    scenario 'cannot see the Delete Project link' do
      visit project_path(project)
      expect(page).not_to have_content 'Delete Project'
    end
  end

  context 'admin user' do
    before { login_as admin }

    scenario 'can see the New Project link' do
      visit root_path
      expect(page).to have_content 'New Project'
    end

    scenario 'can see the Delete Project link' do
      visit project_path(project)
      expect(page).to have_content 'Delete Project'
    end
  end
end

require 'rails_helper'

RSpec.feature 'Users can view the tickets' do
  before do
    atom = FactoryGirl.create(:project, name: 'Atom 2')
    FactoryGirl.create(:ticket, project: atom, name: 'Make it cool', description: 'please add animations!!' )
    vim = FactoryGirl.create(:project, name: 'vim')
    FactoryGirl.create(:ticket, project: vim, name: 'Make it fun', description: 'Emojis and more!' )
    visit root_path
  end

  scenario 'for a certain project' do
    click_link 'Atom'
    expect(page).to have_content 'Make it cool'
    expect(page).not_to have_content 'Make it fun'

    click_link 'Make it cool'

    within('#ticket h2') do
      expect(page).to have_content 'Make it cool'
    end

    expect(page).to have_content 'please add animations!!'

  end
end

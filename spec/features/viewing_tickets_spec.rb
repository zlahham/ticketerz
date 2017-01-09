require 'rails_helper'

feature 'Users can view the tickets' do
  before do
    author = create(:user)

    atom = create(:project, name: 'Atom 2')
    create(:ticket, project: atom, author: author, name: 'Make it cool', description: 'please add animations!!')

    vim = create(:project, name: 'vim')
    create(:ticket, project: vim, author: author, name: 'Make it fun', description: 'Emojis and more!')

    login_as(author)
    assign_role!(author, :viewer, atom)
  end

  scenario 'for a certain project' do
    visit root_path
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

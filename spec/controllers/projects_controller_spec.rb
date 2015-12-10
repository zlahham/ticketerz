require 'rails_helper'

describe ProjectsController, type: :controller do
  it 'handles a missing project correctly' do
    get :show, id: 'not-here'

    expect(response).to redirect_to projects_path

    message =  'The project that you were looking for could not be found.'
    expect(flash[:alert]).to eq message
  end
end

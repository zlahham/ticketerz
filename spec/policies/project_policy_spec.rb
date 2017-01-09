require 'rails_helper'

RSpec.describe ProjectPolicy do
  let(:user)    { create(:user) }
  let(:project) { create(:project) }

  subject { described_class }

  permissions :show? do
    it 'blocks anonymous users' do
      expect(subject).not_to permit(nil, project)
    end

    it 'allows viewers of the project' do
      assign_role!(user, :viewer, project)
      expect(subject).to permit(user, project)
    end

    it 'allows editors of the project' do
      assign_role!(user, :editor, project)
      expect(subject).to permit(user, project)
    end

    it 'allows managers of the project' do
      assign_role!(user, :manager, project)
      expect(subject).to permit(user, project)
    end

    it 'allows admins of the project' do
      admin = create(:user, :admin)
      expect(subject).to permit(admin, project)
    end

    it 'doesnt allow users assigned to other projects' do
      other_project = create(:project)
      assign_role!(user, :manager, other_project)
      expect(subject).not_to permit(user, project)
    end
  end
end

require 'rails_helper'

RSpec.describe ProjectPolicy do
  context 'policy_scope' do
    let(:user)    { create(:user) }
    let(:project) { create(:project) }

    subject { Pundit.policy_scope(user, Project) }

    it 'is empty for anonymous users' do
      expect(Pundit.policy_scope(nil, Project)).to be_empty
    end

    it 'includes projects a user is allowed to view' do
      assign_role!(user, :viewer, project)
      expect(subject).to include(project)
    end

    it "doesn't include projects a user is not allowed to view" do
      expect(subject).to be_empty
    end

    it 'returns all projects for admins' do
      user.admin = true
      expect(subject).to include(project)
    end
  end

  context 'permissions' do
    subject { ProjectPolicy.new(user, project) }

    let(:user)     { create(:user) }
    let(:project)  { create(:project) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { is_expected.not_to permit_action :show }
      it { is_expected.not_to permit_action :update }
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.not_to permit_action :update }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.not_to permit_action :update }
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end

    context 'for managers of another project' do
      before { assign_role!(user, :manager, create(:project)) }

      it { is_expected.not_to permit_action :show }
      it { is_expected.not_to permit_action :update }
    end

    context 'for admins of the project' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :update }
    end
  end
end

require 'rails_helper'

describe TicketPolicy do
  context 'permissions' do
    subject { TicketPolicy.new(user, ticket) }

    let(:user)    { create(:user) }
    let(:project) { create(:project) }
    let(:ticket)  { create(:ticket, project: project) }

    context 'for anonymous users' do
      let(:user) { nil }

      it { is_expected.not_to permit_action :show }
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { is_expected.to permit_action :show }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { is_expected.to permit_action :show }
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      it { is_expected.to permit_action :show }
    end

    context 'for managers of other projects' do
      before do
        assign_role!(user, :manager, create(:project))
      end

      it { is_expected.not_to permit_action :show }
    end

    context 'for administrators' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to permit_action :show }
    end
  end
end

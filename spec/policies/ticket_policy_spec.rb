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
      it { is_expected.not_to permit_action :create }
      it { is_expected.not_to permit_action :update }
      it { is_expected.not_to permit_action :destroy }
    end

    context 'for viewers of the project' do
      before { assign_role!(user, :viewer, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.not_to permit_action :create }
      it { is_expected.not_to permit_action :update }
      it { is_expected.not_to permit_action :destroy }
    end

    context 'for editors of the project' do
      before { assign_role!(user, :editor, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :create }
      it { is_expected.not_to permit_action :update }
      it { is_expected.not_to permit_action :destroy }

      context 'when the editor created the ticket' do
        before { ticket.author = user }

        it { is_expected.to permit_action :update }
      end
    end

    context 'for managers of the project' do
      before { assign_role!(user, :manager, project) }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :update }
      it { is_expected.to permit_action :destroy }
    end

    context 'for managers of other projects' do
      before do
        assign_role!(user, :manager, create(:project))
      end

      it { is_expected.not_to permit_action :show }
      it { is_expected.not_to permit_action :create }
      it { is_expected.not_to permit_action :update }
      it { is_expected.not_to permit_action :destroy }
    end

    context 'for administrators' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to permit_action :show }
      it { is_expected.to permit_action :create }
      it { is_expected.to permit_action :update }
      it { is_expected.to permit_action :destroy }
    end
  end
end

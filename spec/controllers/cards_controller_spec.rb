require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:permission_acls) do
    [
      build(:permission_acl, model: 'card', action: 'index')
    ]
  end
  let(:permission_roles) { [double(permission_acls: permission_acls)] }
  let(:current_user)     { create :user }

  before do
    sign_in current_user
    allow(controller).to receive(:authenticate_user!) { true }
    allow(controller.current_user).to receive(:permission_roles) { permission_roles }
  end

  describe 'GET #index' do
    it 'assigns @cards' do
      create_list(:client, 5)
      create_list(:person, 5)
      create_list(:project, 5)
      create_list(:technology, 5)
      get :index, format: :json
      expect(assigns(:cards)).to have(20).items
    end
  end
end

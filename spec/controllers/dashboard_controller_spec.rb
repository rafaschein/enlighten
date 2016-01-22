require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:permission_acls) do
    [
      build(:permission_acl, model: 'dashboard', action: 'index')
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
    it 'renders the :index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end

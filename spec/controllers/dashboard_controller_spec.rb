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
    it 'assigns @technologies' do
      technologies = create_list(:technology, 22)
      get :index
      expect(assigns(:technologies)).to eq(technologies)
    end

    it 'assigns @people' do
      people = create_list(:person, 22)
      get :index
      expect(assigns(:people)).to eq(people)
    end

    it 'assigns @clients' do
      clients = create_list(:client, 22)
      get :index
      expect(assigns(:clients)).to eq(clients)
    end

    it 'assigns @projects' do
      projects = create_list(:project, 22)
      get :index
      expect(assigns(:projects)).to eq(projects)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end

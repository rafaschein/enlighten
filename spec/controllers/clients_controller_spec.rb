require 'rails_helper'

RSpec.describe ClientsController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe 'GET #index' do
    it 'assigns @clients' do
      clients = create_list(:client, 22)
      get :index
      expect(assigns(:clients)).to eq(clients)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    before do
      @client = create :client
    end

    it 'assigns the requested client to @client' do
      get :edit, id: @client.id
      expect(assigns(:client)).to eq(@client)
    end

    it 'renders the :edit template' do
      get :edit, id: @client.id
      expect(response).to render_template('edit')
    end
  end

  describe 'GET #show' do
    before do
      @client = create :client
    end

    it 'assigns the requested client to @client' do
      get :show, id: @client.id
      expect(assigns(:client)).to eq(@client)
    end

    it 'renders the :show template' do
      get :show, id: @client.id
      expect(response).to render_template('show')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new client in the database' do
        expect do
          post :create, client: attributes_for(:client)
        end.to change(Client, :count).by(1)
      end

      it 'redirects to the client #show' do
        post :create, client: attributes_for(:client)
        expect(response).to redirect_to(assigns(:client))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new client in the database' do
        expect do
          post :create, client: attributes_for(:invalid_client)
        end.to_not change(Client, :count)
      end

      it 're-renders the :new template' do
        post :create, client: attributes_for(:invalid_client)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      @client = create :client
    end

    context 'with valid attributes' do
      it 'assigns the requested client to @client' do
        put :update, id: @client.id, client: attributes_for(:client)
        expect(assigns(:client)).to eq(@client)
      end

      it 'changes the @client attributes' do
        put :update, id: @client, client: attributes_for(:client, name: 'updated-name')
        @client.reload
        expect(@client.name).to eq 'updated-name'
      end

      it 'redirects to the updated client' do
        put :update, id: @client, client: attributes_for(:client, name: 'updated-name')
        expect(response).to redirect_to(@client)
      end
    end

    context 'with invalid attributes' do
      it 'assigns the requested client to @client' do
        put :update, id: @client.id, client: attributes_for(:invalid_client)
        expect(assigns(:client)).to eq(@client)
      end

      it 'does not change the @client attributes' do
        expect do
          put :update, id: @client, client: attributes_for(:invalid_client)
          @client.reload
        end.to_not change(@client, :name)
      end

      it 're-renders the :edit template' do
        put :update, id: @client, client: attributes_for(:invalid_client)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @client = create :client
    end

    it 'deletes the client' do
      expect{ delete :destroy, id: @client.id }.to change(Client, :count).by(-1)
    end

    it 'redirects to client index' do
      delete :destroy, id: @client.id
      expect(response).to redirect_to(clients_url)
    end
  end

end

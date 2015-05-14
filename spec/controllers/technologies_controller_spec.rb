require 'rails_helper'

RSpec.describe TechnologiesController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe 'GET #index' do
    it 'assigns @technologies' do
      technologies = create_list(:technology, 22)
      get :index
      expect(assigns(:technologies)).to eq(technologies)
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
      @technology = create :technology
    end

    it 'assigns the requested technology to @technology' do
      get :edit, id: @technology.id
      expect(assigns(:technology)).to eq(@technology)
    end

    it 'renders the :edit template' do
      get :edit, id: @technology.id
      expect(response).to render_template('edit')
    end
  end

  describe 'GET #show' do
    before do
      @technology = create :technology
    end

    it 'assigns the requested technology to @technology' do
      get :show, id: @technology.id
      expect(assigns(:technology)).to eq(@technology)
    end

    it 'renders the :show template' do
      get :show, id: @technology.id
      expect(response).to render_template('show')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:image_file) { fixture_file_upload('files/300x300.gif', 'image/gif') }

      it 'saves the new technology in the database' do
        expect do
          post :create, technology: attributes_for(:technology, image: image_file)
        end.to change(Technology, :count).by(1)
      end

      it 'redirects to the technology #show' do
        post :create, technology: attributes_for(:technology)
        expect(response).to redirect_to(assigns(:technology))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new technology in the database' do
        expect do
          post :create, technology: attributes_for(:invalid_technology)
        end.to_not change(Technology, :count)
      end

      it 're-renders the :new template' do
        post :create, technology: attributes_for(:invalid_technology)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      @technology = create :technology
    end

    context 'with valid attributes' do
      let(:image_file) { fixture_file_upload('files/300x300.gif', 'image/gif') }

      it 'assigns the requested technology to @technology' do
        put :update, id: @technology.id, technology: attributes_for(:technology, image: image_file)
        expect(assigns(:technology)).to eq(@technology)
      end

      it 'changes the @technology attributes' do
        put :update, id: @technology, technology: attributes_for(:technology, name: 'updated-name', image: image_file)
        @technology.reload
        expect(@technology.name).to eq 'updated-name'
      end

      it 'redirects to the updated technology' do
        put :update, id: @technology, technology: attributes_for(:technology, name: 'updated-name', image: image_file)
        expect(response).to redirect_to(@technology)
      end
    end

    context 'with invalid attributes' do
      it 'assigns the requested technology to @technology' do
        put :update, id: @technology.id, technology: attributes_for(:invalid_technology)
        expect(assigns(:technology)).to eq(@technology)
      end

      it 'does not change the @technology attributes' do
        expect do
          put :update, id: @technology, technology: attributes_for(:invalid_technology)
          @technology.reload
        end.to_not change(@technology, :name)
      end

      it 're-renders the :edit template' do
        put :update, id: @technology, technology: attributes_for(:invalid_technology)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @technology = create :technology
    end

    it 'deletes the technology' do
      expect { delete :destroy, id: @technology.id }.to change(Technology, :count).by(-1)
    end

    it 'redirects to technology index' do
      delete :destroy, id: @technology.id
      expect(response).to redirect_to(technologies_url)
    end
  end

end

require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe 'GET #index' do
    it 'assigns @people' do
      people = create_list(:person, 22)
      get :index
      expect(assigns(:people)).to eq(people)
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
      @person = create :person
    end

    it 'assigns the requested person to @person' do
      get :edit, id: @person.id
      expect(assigns(:person)).to eq(@person)
    end

    it 'renders the :edit template' do
      get :edit, id: @person.id
      expect(response).to render_template('edit')
    end
  end

  describe 'GET #show' do
    before do
      @person = create :person
    end

    it 'assigns the requested person to @person' do
      get :show, id: @person.id
      expect(assigns(:person)).to eq(@person)
    end

    it 'renders the :show template' do
      get :show, id: @person.id
      expect(response).to render_template('show')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new person in the database' do
        expect do
          post :create, person: attributes_for(:person)
        end.to change(Person, :count).by(1)
      end

      it 'redirects to the person #show' do
        post :create, person: attributes_for(:person)
        expect(response).to redirect_to(assigns(:person))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new person in the database' do
        expect do
          post :create, person: attributes_for(:invalid_person)
        end.to_not change(Person, :count)
      end

      it 're-renders the :new template' do
        post :create, person: attributes_for(:invalid_person)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      @person = create :person
    end

    context 'with valid attributes' do
      it 'assigns the requested person to @person' do
        put :update, id: @person.id, person: attributes_for(:person)
        expect(assigns(:person)).to eq(@person)
      end

      it 'changes the @person attributes' do
        put :update, id: @person, person: attributes_for(:person, name: 'updated-name')
        @person.reload
        expect(@person.name).to eq 'updated-name'
      end

      it 'redirects to the updated person' do
        put :update, id: @person, person: attributes_for(:person, name: 'updated-name')
        expect(response).to redirect_to(@person)
      end
    end

    context 'with invalid attributes' do
      it 'assigns the requested person to @person' do
        put :update, id: @person.id, person: attributes_for(:invalid_person)
        expect(assigns(:person)).to eq(@person)
      end

      it 'does not change the @person attributes' do
        expect do
          put :update, id: @person, person: attributes_for(:invalid_person)
          @person.reload
        end.to_not change(@person, :name)
      end

      it 're-renders the :edit template' do
        put :update, id: @person, person: attributes_for(:invalid_person)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @person = create :person
    end

    it 'deletes the person' do
      expect { delete :destroy, id: @person.id }.to change(Person, :count).by(-1)
    end

    it 'redirects to person index' do
      delete :destroy, id: @person.id
      expect(response).to redirect_to(people_url)
    end
  end

end

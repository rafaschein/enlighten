require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    allow(controller).to receive(:authenticate_user!).and_return true
  end

  describe 'GET #index' do
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

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'GET #edit' do
    before do
      @project = create :project
    end

    it 'assigns the requested project to @project' do
      get :edit, id: @project.id
      expect(assigns(:project)).to eq(@project)
    end

    it 'renders the :edit template' do
      get :edit, id: @project.id
      expect(response).to render_template('edit')
    end
  end

  describe 'GET #show' do
    before do
      @project = create :project
    end

    it 'assigns the requested project to @project' do
      get :show, id: @project.id
      expect(assigns(:project)).to eq(@project)
    end

    it 'renders the :show template' do
      get :show, id: @project.id
      expect(response).to render_template('show')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:image_file) { fixture_file_upload('files/300x300.gif', 'image/gif') }

      it 'saves the new project in the database' do
        expect do
          post :create, project: attributes_for(:project, image: image_file)
        end.to change(Project, :count).by(1)
      end

      it 'redirects to the project #show' do
        post :create, project: attributes_for(:project)
        expect(response).to redirect_to(assigns(:project))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new project in the database' do
        expect do
          post :create, project: attributes_for(:invalid_project)
        end.to_not change(Project, :count)
      end

      it 're-renders the :new template' do
        post :create, project: attributes_for(:invalid_project)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    before do
      @project = create :project
    end

    context 'with valid attributes' do
      let(:image_file) { fixture_file_upload('files/300x300.gif', 'image/gif') }

      it 'assigns the requested project to @project' do
        put :update, id: @project.id, project: attributes_for(:project, image: image_file)
        expect(assigns(:project)).to eq(@project)
      end

      it 'changes the @project attributes' do
        put :update, id: @project, project: attributes_for(:project, name: 'updated-name', image: image_file)
        @project.reload
        expect(@project.name).to eq 'updated-name'
      end

      it 'redirects to the updated project' do
        put :update, id: @project, project: attributes_for(:project, name: 'updated-name', image: image_file)
        expect(response).to redirect_to(@project)
      end
    end

    context 'with invalid attributes' do
      it 'assigns the requested project to @project' do
        put :update, id: @project.id, project: attributes_for(:invalid_project)
        expect(assigns(:project)).to eq(@project)
      end

      it 'does not change the @project attributes' do
        expect do
          put :update, id: @project, project: attributes_for(:invalid_project)
          @project.reload
        end.to_not change(@project, :name)
      end

      it 're-renders the :edit template' do
        put :update, id: @project, project: attributes_for(:invalid_project)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @project = create :project
    end

    it 'deletes the project' do
      expect { delete :destroy, id: @project.id }.to change(Project, :count).by(-1)
    end

    it 'redirects to project index' do
      delete :destroy, id: @project.id
      expect(response).to redirect_to(projects_url)
    end
  end

  describe 'PUT #follow' do
    let(:user) { create :user }
    let(:project) { create :project }

    before do
      sign_in user
    end

    subject { put :follow, id: project.id }

    it 'current user follow project' do
      subject
      project.reload

      expect(project.followers).to include(user)
      expect(response).to redirect_to(project)
    end

    it 'current user try follow already followed project' do
      project.followers << user

      subject
      project.reload

      expect(controller.current_user).not_to receive(:save)
      expect(project.followers).to eq [user]
      expect(response).to redirect_to(project)
    end
  end

  describe 'PUT #unfollow' do
    let(:user) { create :user }
    let(:project) { create :project }

    before do
      sign_in user
    end

    subject { put :unfollow, id: project.id }

    it 'current user already unfollowed project' do
      project.followers << user

      expect(controller.current_user.followed_projects).to receive(:delete)
      expect(controller.current_user).to receive(:save)

      subject
    end

    it 'current user unfollow project' do
      project.followers << user

      subject
      project.reload

      expect(project.followers).to eq []
      expect(response).to redirect_to(project)
    end
  end

  describe 'PUT #like' do
    let(:user) { create :user }
    let(:project) { create :project }

    before do
      sign_in user
    end

    subject { put :like, id: project.id }

    it 'current user like project' do
      subject
      project.reload

      expect(project.likers).to include(user)
      expect(response).to redirect_to(project)
    end

    it 'current user try like already liked project' do
      project.likers << user

      subject
      project.reload

      expect(controller.current_user).not_to receive(:save)
      expect(project.likers).to eq [user]
      expect(response).to redirect_to(project)
    end
  end

  describe 'PUT #unlike' do
    let(:user) { create :user }
    let(:project) { create :project }

    before do
      sign_in user
    end

    subject { put :unlike, id: project.id }

    it 'current user already liked project' do
      project.likers << user

      expect(controller.current_user.liked_projects).to receive(:delete)
      expect(controller.current_user).to receive(:save)

      subject
    end

    it 'current user unlike project' do
      project.likers << user

      subject
      project.reload

      expect(project.likers).to eq []
      expect(response).to redirect_to(project)
    end
  end
end

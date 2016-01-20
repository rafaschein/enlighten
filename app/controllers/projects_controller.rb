class ProjectsController < ApplicationController
  before_action :set_project, only: [:card, :show, :edit, :update, :destroy, :follow, :unfollow, :like, :unlike]

  # GET /projects
  def index
    @projects = Project.all
    authorize :project, :index?
  end

  # GET /projects/cards.json
  def cards
    @projects = paginate Card::Project.all(current_user)

    respond_to do |format|
      format.json { render json: @projects, each_serializer: CardSerializer }
    end
  end

  # GET /projects/1
  def show
    authorize @project, :show?
  end

  # GET /project/1/card.json
  def card
    respond_to do |format|
      format.json do
        render json: Card::Project.new(@project, current_user), serializer: CardSerializer
      end
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    authorize @project, :new?
  end

  # GET /projects/1/edit
  def edit
    authorize @project, :edit?
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    authorize @project, :create?

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    authorize @project, :update?

    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    authorize @project, :destroy?
    @project.destroy

    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  # PATCH/PUT /follow
  def follow
    authorize @project, :follow?
    current_user.followed_projects << @project

    if current_user.save
      respond_to do |format|
        format.html { redirect_to @project, notice: "You're following the project." }
        format.json { head :created }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to do |format|
      format.html { redirect_to @project, notice: "You're already following the project." }
      format.json { head :created }
    end
  end

  # PATCH/PUT /follow
  def unfollow
    authorize @project, :unfollow?

    if current_user.followed_projects.include?(@project)
      current_user.followed_projects.delete(@project)
      current_user.save
    end

    respond_to do |format|
      format.html { redirect_to @project, notice: "You're not following the project." }
      format.json { head :created }
    end
  end

  # PATCH/PUT /like
  def like
    authorize @project, :like?
    current_user.liked_projects << @project

    if current_user.save
      respond_to do |format|
        format.html { redirect_to @project, notice: 'You liked the project.' }
        format.json { head :created }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to do |format|
      format.html { redirect_to @project, notice: 'You already liked the project.' }
      format.json { head :created }
    end
  end

  # PATCH/PUT /like
  def unlike
    authorize @project, :unlike?

    if current_user.liked_projects.include?(@project)
      current_user.liked_projects.delete(@project)
      current_user.save
    end

    respond_to do |format|
      format.html { redirect_to @project, notice: "You're not liking the project." }
      format.json { head :created }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(
      :name,
      :client_id,
      :description,
      :scm_type,
      :scm_reference,
      :image,
      technology_ids: [],
      members_attributes: [:id, :person_id, :role_id, :period_start, :period_end, :_destroy],
      screenshots_attributes: [:id, :image, :description, :_destroy])
  end
end

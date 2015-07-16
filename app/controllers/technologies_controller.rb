class TechnologiesController < ApplicationController
  before_action :set_technology, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :like, :unlike]

  # GET /technologies
  def index
    @technologies = Technology.all
  end

  # GET /technologies/1
  def show
  end

  # GET /technologies/new
  def new
    @technology = Technology.new
  end

  # GET /technologies/1/edit
  def edit
  end

  # POST /technologies
  def create
    @technology = Technology.new(technology_params)

    if @technology.save
      redirect_to @technology, notice: 'Technology was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /technologies/1
  def update
    if @technology.update(technology_params)
      redirect_to @technology, notice: 'Technology was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /technologies/1
  def destroy
    @technology.destroy

    redirect_to technologies_url, notice: 'Technology was successfully destroyed.'
  end

  # PATCH/PUT /follow
  def follow
    current_user.followed_technologies << @technology

    if current_user.save
      redirect_to @technology, notice: "You're following the technology."
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @technology, notice: "You're already following the technology."
  end

  # PATCH/PUT /follow
  def unfollow
    if current_user.followed_technologies.include?(@technology)
      current_user.followed_technologies.delete(@technology)
      current_user.save
    end

    redirect_to @technology, notice: "You're not following the technology."
  end

  # PATCH/PUT /like
  def like
    current_user.liked_technologies << @technology

    if current_user.save
      redirect_to @technology, notice: "You're liked the technology."
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @technology, notice: "You're already liked the technology."
  end

  # PATCH/PUT /like
  def unlike
    if current_user.liked_technologies.include?(@technology)
      current_user.liked_technologies.delete(@technology)
      current_user.save
    end

    redirect_to @technology, notice: "You're not liking the technology."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_technology
    @technology = Technology.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def technology_params
    params.require(:technology).permit(:name, :website, :image)
  end
end

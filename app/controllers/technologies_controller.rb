class TechnologiesController < ApplicationController
  before_action :set_technology, only: [:card, :show, :edit, :update, :destroy, :follow, :unfollow, :like, :unlike]

  # GET /technologies
  def index
    @technologies = Technology.all
    authorize :technology, :index?
  end

  # GET /technologies/cards.json
  def cards
    @technologies = paginate Card::Technology.all(current_user)

    respond_to do |format|
      format.json { render json: @technologies, each_serializer: CardSerializer }
    end
  end

  # GET /technologies/1
  def show
    authorize @technology, :show?
  end

  # GET /technologies/1/card.json
  def card
    respond_to do |format|
      format.json do
        render json: Card::Technology.new(@technology, current_user), serializer: CardSerializer
      end
    end
  end

  # GET /technologies/new
  def new
    @technology = Technology.new
    authorize @technology, :new?
  end

  # GET /technologies/1/edit
  def edit
    authorize @technology, :edit?
  end

  # POST /technologies
  def create
    @technology = Technology.new(technology_params)
    authorize @technology, :create?

    if @technology.save
      redirect_to @technology, notice: 'Technology was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /technologies/1
  def update
    authorize @technology, :update?

    if @technology.update(technology_params)
      redirect_to @technology, notice: 'Technology was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /technologies/1
  def destroy
    authorize @technology, :destroy?
    @technology.destroy

    redirect_to technologies_url, notice: 'Technology was successfully destroyed.'
  end

  # PATCH/PUT /follow
  def follow
    authorize @technology, :follow?
    current_user.followed_technologies << @technology

    if current_user.save
      respond_to do |format|
        format.html { redirect_to @technology, notice: "You're following the technology." }
        format.json { head :created }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to do |format|
      format.html { redirect_to @technology, notice: "You're already following the technology." }
      format.json { head :created }
    end
  end

  # PATCH/PUT /follow
  def unfollow
    authorize @technology, :unfollow?

    if current_user.followed_technologies.include?(@technology)
      current_user.followed_technologies.delete(@technology)
      current_user.save
    end

    respond_to do |format|
      format.html { redirect_to @technology, notice: "You're not following the technology." }
      format.json { head :created }
    end
  end

  # PATCH/PUT /like
  def like
    authorize @technology, :like?
    current_user.liked_technologies << @technology

    if current_user.save
      respond_to do |format|
        format.html { redirect_to @technology, notice: 'You liked the technology.' }
        format.json { head :created }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to do |format|
      format.html { redirect_to @technology, notice: 'You already liked the technology.' }
      format.json { head :created }
    end
  end

  # PATCH/PUT /like
  def unlike
    authorize @technology, :unlike?

    if current_user.liked_technologies.include?(@technology)
      current_user.liked_technologies.delete(@technology)
      current_user.save
    end

    respond_to do |format|
      format.html { redirect_to @technology, notice: "You're not liking the technology." }
      format.json { head :created }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_technology
    @technology = Technology.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def technology_params
    params.require(:technology).permit(:name, :website, :image, :technology_category_id, :parent_id)
  end
end

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :like, :unlike]

  # GET /people
  def index
    @people = Person.all
  end

  # GET /people/1
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person, notice: 'Person was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /people/1
  def update
    if @person.update(person_params)
      redirect_to @person, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /people/1
  def destroy
    @person.destroy

    redirect_to people_url, notice: 'Person was successfully destroyed.'
  end

  # PATCH/PUT /follow
  def follow
    current_user.followed_people << @person

    if current_user.save
      redirect_to @person, notice: "You're following the person."
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @person, notice: "You're already following the person."
  end

  # PATCH/PUT /follow
  def unfollow
    if current_user.followed_people.include?(@person)
      current_user.followed_people.delete(@person)
      current_user.save
    end

    redirect_to @person, notice: "You're not following the person."
  end

  # PATCH/PUT /like
  def like
    current_user.liked_people << @person

    if current_user.save
      redirect_to person_path, notice: 'You liked the person.'
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @person, notice: 'You already liked the person.'
  end

  # PATCH/PUT /like
  def unlike
    if current_user.liked_people.include?(@person)
      current_user.liked_people.delete(@person)
      current_user.save
    end

    redirect_to @person, notice: "You're not liking the person."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:person).permit(
      :user_id,
      :name,
      :image,
      social_links_attributes: [:id, :provider, :identifier, :_destroy],
      technologies_attributes: [:id, :technology_id, :skill_rating, :certificated, :_destroy])
  end
end

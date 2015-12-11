class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :like, :unlike]

  # GET /clients
  def index
    @clients = Client.all
    authorize :client, :index?
  end

  # GET /clients/1
  def show
    authorize @client, :show?
  end

  # GET /clients/new
  def new
    @client = Client.new
    authorize @client, :new?
  end

  # GET /clients/1/edit
  def edit
    authorize @client, :edit?
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    authorize @client, :create?

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    authorize @client, :update?

    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    authorize @client, :destroy?
    @client.destroy

    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  # PATCH/PUT /follow
  def follow
    authorize @client, :follow?
    current_user.followed_clients << @client

    if current_user.save
      redirect_to @client, notice: "You're following the client."
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @client, notice: "You're already following the client."
  end

  # PATCH/PUT /follow
  def unfollow
    authorize @client, :unfollow?

    if current_user.followed_clients.include?(@client)
      current_user.followed_clients.delete(@client)
      current_user.save
    end

    redirect_to @client, notice: "You're not following the client."
  end

  # PATCH/PUT /like
  def like
    authorize @client, :like?
    current_user.liked_clients << @client

    if current_user.save
      redirect_to client_path, notice: 'You liked the client.'
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to @client, notice: 'You already liked the client.'
  end

  # PATCH/PUT /like
  def unlike
    authorize @client, :unlike?

    if current_user.liked_clients.include?(@client)
      current_user.liked_clients.delete(@client)
      current_user.save
    end

    redirect_to @client, notice: "You're not liking the client."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def client_params
    params.require(:client).permit(:name, :website, :image)
  end
end

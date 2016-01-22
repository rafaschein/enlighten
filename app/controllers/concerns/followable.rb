module Followable
  extend ActiveSupport::Concern

  # PATCH/PUT /follow
  def follow
    authorize follow_controller, :follow?
    follow_method.push(follow_model)

    if current_user.save
      respond_to_followers("You're following the #{controller_name.singularize}.")
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to_followers("You're already following the #{controller_name.singularize}.")
  end

  # PATCH/PUT /follow
  def unfollow
    authorize follow_controller, :unfollow?

    if follow_method.include?(follow_model)
      follow_method.delete(follow_model)
      current_user.save
    end

    respond_to_followers("You're not following the #{controller_name.singularize}.")
  end

  private

  def respond_to_followers(notice)
    respond_to do |format|
      format.html { redirect_to follow_model, notice: notice }
      format.json { head :created }
    end
  end

  def follow_method
    current_user.send("followed_#{controller_name}".to_sym)
  end

  def follow_model
    send("set_#{controller_name.singularize}".to_sym)
  end

  def follow_controller
    controller_name.singularize.to_sym
  end
end

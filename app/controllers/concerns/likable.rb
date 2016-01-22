module Likable
  extend ActiveSupport::Concern

  # PATCH/PUT /like
  def like
    authorize like_controller, :like?
    like_method.push(like_model)

    if current_user.save
      respond_to_likers("You're liking the #{controller_name.singularize}.")
    end
  rescue ActiveRecord::RecordNotUnique
    respond_to_likers("You're already liking the #{controller_name.singularize}.")
  end

  # PATCH/PUT /like
  def unlike
    authorize like_controller, :unlike?

    if like_method.include?(like_model)
      like_method.delete(like_model)
      current_user.save
    end

    respond_to_likers("You're not liking the #{controller_name.singularize}.")
  end

  private

  def respond_to_likers(notice)
    respond_to do |format|
      format.html { redirect_to like_model, notice: notice }
      format.json { head :created }
    end
  end

  def like_method
    current_user.send("liked_#{controller_name}".to_sym)
  end

  def like_model
    send("set_#{controller_name.singularize}".to_sym)
  end

  def like_controller
    controller_name.singularize.to_sym
  end
end

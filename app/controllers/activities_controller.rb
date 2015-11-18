class ActivitiesController < ApplicationController
  class InvalidParamsError < StandardError
  end

  # POST /:owner/:owner_id/activities/:type
  # POST /:owner/:owner_id/activities/:types.json
  def create
    @activity = create_activity
    authorize @activity, :create?

    if @activity.save
      render json: { id: @activity.id }, status: :created
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  private

  def owner_model_name
    params[:owner]
  end

  def type_model_name
    params[:type]
  end

  def owner
    id_key = "#{owner_model_name}_id".to_sym
    @owner ||= owner_model_name.capitalize.constantize.find(params[id_key])
  end

  def type
    @type_model ||= type_model_name.capitalize.constantize
  end

  def create_activity
    activity = owner.activities.build
    activity_item = type.new(activity_params)

    activity.user = current_user
    activity.item = activity_item if activity_item.valid?

    activity
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_type_params(type)
    {
      post: [:body]
    }[type.to_sym]
  end

  def activity_params
    params.require(params[:type]).permit(*activity_type_params(params[:type]))
  end
end

module Admin
  class SubmissionsController < Admin::ApplicationController
    before_action :default_params

    def default_params
      resource_params = params.fetch(resource_name, {})
      order = resource_params.fetch(:order, "created_at")
      direction = resource_params.fetch(:direction, "desc")
      params[resource_name] = resource_params.merge(order: order, direction: direction)
    end

    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    
    # def index
    #   super
    #   @resources = Submission.order(created_at: :desc).
    #     page(params[:page]).
    #     per(1)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Submission.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information

    def valid_action?(name, resource = resource_class)
      %w[destroy].exclude?(name.to_s) && super
    end

  end
end

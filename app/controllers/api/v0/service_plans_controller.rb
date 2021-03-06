module Api
  module V0
    class ServicePlansController < ApplicationController
      include Api::Mixins::IndexMixin
      include Api::Mixins::ShowMixin

      def order
        service_plan = model.find(service_plan_id)
        task = Task.create!(:tenant => service_plan.tenant, :status => "started")

        #TODO: Publish a message with service plan ordering messaging client and simply
        # return the task id, let the messaging client handle updating the task.
        order_service_plan_and_update_task(task, service_plan)

        render :json => {:task_id => task.id}
      rescue ActiveRecord::RecordNotFound
        head :bad_request
      end

      private

      def order_service_plan_and_update_task(task, service_plan)
        task.context = service_plan.order(order_params)
        task.status = "completed"
        task.save!
      end

      def service_plan_id
        params[:service_plan_id].to_i
      end

      def order_params
        params.permit(
          :service_parameters          => {},
          :provider_control_parameters => {}
        ).to_h
      end

      def list_params
        params.permit(:source_id, :tenant_id, :service_offering_id)
      end

      def model
        ServicePlan
      end
    end
  end
end

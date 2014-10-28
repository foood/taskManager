class TasksController < ApplicationController
  before_action :all_tasks, only: [:index, :create, :update, :destroy, :update_row_order]
  before_action :set_tasks, only: [:edit, :update, :destroy]
  respond_to :html, :js

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    
  end

  def update
    @task.update_attributes(task_params)


  end

  def destroy
    @task.destroy

  end
  
  def update_row_order
    @task = Task.find(task_params[:task_id])
    @task.row_order_position = task_params[:row_order_position]
    @task.save

    render nothing: true # this is a POST action, updates sent via AJAX, no view rendered
  end



  private

    def all_tasks
      @tasks = Task.rank(:row_order).all
    end

    def set_tasks
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:task_id, :description, :deadline, :row_order_position)
    end
end

class TasksController < ApplicationController
  def index
    @tasks = Task.order(created_at: :asc)
    render json: { task: @tasks }
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      render json: { task: @task, location: task_url(@task) }, status: :created #200
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity #422
    end
  end

  def show
    @task = Task.find(params[:id])
    render json: { task: @task }
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render json: { tasks: @tasks }, status: :accepted #202
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity #422
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render json: { task: nill }, status: :accepted #202
    else
      render json: { errors: @task.errors }, status: :unprocessable_entity #422
    end
  end

  protected
  def task_params
    params.require(:task).permit(:title, :completed)
  end
end

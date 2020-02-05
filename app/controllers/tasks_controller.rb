class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)

    if @task.save
      redirect_to tasks_path, flash: { success: "タスクを作成しました" }
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(update_params)
      redirect_to tasks_path, flash: { success: "タスクを更新しました" }
    else
      render "edit"
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def create_params
    params.require(:task).permit(:name, :description, :status, :deadline, :priority)
  end

  def update_params
    params.require(:task).permit(:name, :description, :status, :deadline, :priority)
  end
end

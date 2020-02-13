class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.order("created_at desc")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)

    if @task.save
      redirect_to tasks_path, flash: { success: "タスクを作成しました" }
    else
      flash.now[:error] = "タスクの作成に失敗しました"
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
      flash.now[:error] = "タスクの更新に失敗しました"
      render "edit"
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path, flash: { success: "タスクを削除しました" }
    else
      redirect_to tasks_path, flash: { error: "タスクの削除に失敗しました" }
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

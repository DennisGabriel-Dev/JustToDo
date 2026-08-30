class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy toggle]

  # GET /tasks or /tasks.json
  def index
    respond_to do |format|
      format.html { redirect_to "/500", notice: "Rota não existente" }
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task_list_id = params[:task_list_id]
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        @task_list = @task.task_list
        @all_complete = @task_list.tasks.any? && @task_list.tasks.all?(&:status)
        format.html { redirect_to task_list_path(@task_list), notice: t(".success") }
        format.json { render :show, status: :created, location: @task }
        format.turbo_stream
      else
        @task_list_id = task_params[:task_list_id]
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @just_completed = !@task.status
    @task.update!(status: !@task.status)
    @task_list = @task.task_list
    @all_complete = @just_completed && @task_list.tasks.any? && @task_list.tasks.all?(&:status)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to task_list_path(@task_list) }
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to task_lists_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
    head :forbidden and return unless @task.task_list.user_id == current_user.id
  end

  def task_params
    params.require(:task).permit(:title, :status, :task_list_id)
  end
end

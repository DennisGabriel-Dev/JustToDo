class TaskListsController < ApplicationController
  before_action :set_task_list, only: %i[show edit update destroy]

  # GET /task_lists or /task_lists.json
  def index
    @q = TaskList.ransack(params[:q])
    @task_lists = @q.result(distinct: true).where(user_id: current_user.id).ordered
  end

  # GET /task_lists/1 or /task_lists/1.json
  def show; end

  # GET /task_lists/new
  def new
    @task_list = TaskList.new
  end

  # GET /task_lists/1/edit
  def edit; end

  # POST /task_lists or /task_lists.json
  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.user_id = current_user.id
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to task_list_url(@task_list), notice: t('.success') }
        format.json { render :show, status: :created, location: @task_list }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_lists/1 or /task_lists/1.json
  def update
    respond_to do |format|
      if @task_list.update(task_list_params)
        format.html { redirect_to task_list_url(@task_list), notice: 'Task list was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_list }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_lists/1 or /task_lists/1.json
  def destroy
    set_task_list
    @task_list.destroy
    flash[:notice] = t('task_lists.destroy.success')
    respond_to do |format|
      format.html { redirect_to task_lists_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task_list
    @task_list = TaskList.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_list_params
    params.require(:task_list).permit!
  end
end

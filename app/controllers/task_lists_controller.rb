class TaskListsController < ApplicationController
  before_action :set_task_list, only: %i[show edit update destroy reorder]

  def index
    @q = TaskList.ransack(params[:q])
    @task_lists = @q.result(distinct: true).where(user_id: current_user.id).ordered
  end

  def show
    @filter = params[:filter].presence_in(%w[all pending done]) || 'all'
    @tasks = filtered_tasks
  end

  def new
    @task_list = TaskList.new
  end

  def edit; end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.user_id = current_user.id
    respond_to do |format|
      if @task_list.save
        @lists_count = current_user.task_lists.count
        format.html { redirect_to task_list_url(@task_list), notice: t('.success') }
        format.json { render :show, status: :created, location: @task_list }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_list.update(task_list_params)
        format.html { redirect_to task_lists_path, notice: 'Task list was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_list }
        format.turbo_stream
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_list.errors, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task_list.destroy
    flash[:notice] = t('task_lists.destroy.success')
    respond_to do |format|
      format.html { redirect_to task_lists_url }
      format.json { head :no_content }
    end
  end

  def reorder
    Array(params[:task_ids]).each_with_index do |id, index|
      @task_list.tasks.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  private

  def set_task_list
    @task_list = current_user.task_lists.find(params[:id])
  end

  def filtered_tasks
    tasks = @task_list.tasks.ordered
    case @filter
    when 'pending' then tasks.pending
    when 'done' then tasks.done
    else tasks
    end
  end

  def task_list_params
    params.require(:task_list).permit(:name)
  end
end

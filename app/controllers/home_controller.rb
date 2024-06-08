class HomeController < ApplicationController
  def index
      @tasks_lists = TaskList.all
  end
end

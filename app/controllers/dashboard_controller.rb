class DashboardController < ApplicationController
  def index
    #authorize :dashboard, :index?

    @technologies = Technology.all
    @people = Person.all
    @clients = Client.all
    @projects = Project.all
  end
end

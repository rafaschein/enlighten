class DashboardController < ApplicationController
  def index
    @technologies = Technology.all
    @people = Person.all
    @clients = Client.all
    @projects = Project.all
  end
end

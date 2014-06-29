require "rails_helper"

RSpec.describe TasksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "projects/1/tasks").to route_to("tasks#index", project_id: '1', format: :json)
    end

    it "routes to #show" do
      expect(:get => "projects/1/tasks/1").to route_to("tasks#show", :id => "1", project_id: '1', format: :json)
    end

    it "routes to #create" do
      expect(:post => "projects/1/tasks").to route_to("tasks#create", project_id: '1', format: :json)
    end

    it "routes to #update" do
      expect(:put => "projects/1/tasks/1").to route_to("tasks#update", :id => "1", project_id: '1', format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "projects/1/tasks/1").to route_to("tasks#destroy", :id => "1", project_id: '1', format: :json)
    end

    it "routes to #sort" do
      expect(:post => "projects/1/tasks/sort").to route_to("tasks#sort", project_id: '1', format: :json)
    end
  end
end

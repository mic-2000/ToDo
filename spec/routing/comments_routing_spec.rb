require "rails_helper"

RSpec.describe CommentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "comments").to route_to("comments#index", format: :json)
    end

    it "routes to #create" do
      expect(:post => "comments").to route_to("comments#create", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "comments/1").to route_to("comments#destroy", :id => "1", format: :json)
    end
  end
end

require "rails_helper"

RSpec.describe SubmissionsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(:get => "/submissions/1").to route_to("submissions#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/submissions").to route_to("submissions#create")
    end
  end
end

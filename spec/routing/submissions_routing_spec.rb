require "rails_helper"

RSpec.describe SubmissionsController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      token = SecureRandom.uuid
      expect(:get => "/submissions/#{token}").to route_to("submissions#show", token: token)
    end

    it "routes to #create" do
      expect(:post => "/submissions").to route_to("submissions#create")
    end
  end
end

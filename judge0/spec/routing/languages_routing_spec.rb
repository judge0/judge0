require "rails_helper"

RSpec.describe LanguagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/languages").to route_to("languages#index")
    end
  end
end

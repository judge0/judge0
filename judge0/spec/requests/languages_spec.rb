require 'rails_helper'

RSpec.describe "Languages", type: :request do
  describe "GET /languages" do
    it "has a 200 status code" do
      get languages_path
      expect(response).to have_http_status(200)
    end
  end
end

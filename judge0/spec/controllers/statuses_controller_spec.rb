require 'rails_helper'

RSpec.describe StatusesController, type: :controller do
  describe "GET #index" do
    it "returns all statuses" do
      get :index
      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_serialized(Status.all).with(StatusSerializer)
    end
  end
end

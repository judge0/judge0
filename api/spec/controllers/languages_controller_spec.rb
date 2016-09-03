require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  describe "GET #index" do
    it "has a 200 status code" do
      get :index
      expect(response).to be_success
    end

    it "returns all languages" do
      create_list(:language, 10)
      get :index
      expect(JSON.parse(response.body)["data"].size).to eq(10)
    end
  end
end

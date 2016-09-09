require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do
  describe "GET #index" do
    it "returns all languages" do
      create_list(:language, 10)
      get :index
      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_serialized(Language.all).with(LanguageSerializer)
    end
  end
end

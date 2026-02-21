require 'rails_helper'

RSpec.describe SubmissionsController, type: :controller do

  let(:submission) { create(:submission) }

  describe "GET #show" do
    it "returns one submission" do
      get :show, params: { token: submission.token }
      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json).to have_serialized(submission).with(SubmissionSerializer)
    end

    it "returns 404" do
      expect {
        get :show, params: { token: submission.token + " give me 404" }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Submission" do
        expect {
          post :create, params: attributes_for(:valid_submission)
        }.to change(Submission, :count).by(1)
      end

      it "returns only id of new Submission" do
        post :create, params: attributes_for(:valid_submission)
        json = JSON.parse(response.body)
        expect(response).to be_success
        expect(json).to have_serialized(Submission.first).with(SubmissionSerializer, { fields: [:token] })
      end

      it "doesn't create new Submission because given Language doesn't exist" do
        attributes = attributes_for(:valid_submission)
        attributes[:language_id] = 142 # Language with id 142 doesn't exist
        post :create, params: attributes
        expect(response).to have_http_status(422)
      end
    end

    context "with invalid params" do
      it "doesn't create new Submission" do
        post :create, params: { submission: attributes_for(:invalid_submission) }
        expect(response).to have_http_status(422)
      end
    end
  end
end

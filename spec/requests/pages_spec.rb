require 'rails_helper'

RSpec.describe "Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/pages/contact"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /faq" do
    it "returns http success" do
      get "/pages/faq"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /privacy_policy" do
    it "returns http success" do
      get "/pages/privacy_policy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /legal_notice" do
    it "returns http success" do
      get "/pages/legal_notice"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /terms_and_conditions" do
    it "returns http success" do
      get "/pages/terms_and_conditions"
      expect(response).to have_http_status(:success)
    end
  end

end

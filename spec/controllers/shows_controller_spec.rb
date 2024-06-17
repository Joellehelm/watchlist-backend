require 'rails_helper'

RSpec.describe ShowsController do
  let(:show){ FactoryBot.create(:show) }
  let(:user){ FactoryBot.create(:user) }

  before do
    user_login(user)
  end

  describe "GET index" do
    it "returns all shows" do
      puts "WE IN THE TEST==================="
      get :index
      puts JSON.parse(response.body)
    end
  end
end
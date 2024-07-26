require 'rails_helper'

RSpec.describe UserShowsController, type: :controller do
  let!(:show) { FactoryBot.create(:show) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_show) { UserShow.create(user_id: user.id, show_id: show.id) }

  before do
    @token = user_login(user)
  end

  describe "DESTROY user_show" do
    it "deletes a user_show" do
      expect(UserShow.count).to eq(1)
      request_headers(@token)
      delete :destroy, :params => { id: user_show.id }

      expect(response.status).to eq(200)
      expect(UserShow.count).to eq(0)
    end
  end
end
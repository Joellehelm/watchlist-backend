RSpec.describe ShowsController, type: :controller do
  let!(:show) { FactoryBot.create(:show) }
  let!(:show2) { FactoryBot.create(:show, name: 'Cobra Kai', imdbID: 'tt7221388') }
  let!(:user) { FactoryBot.create(:user) }

  before do
    @token = user_login(user)
  end

  describe "GET index" do
    it "Returns all shows" do
      request_headers
      get :index
      parsed_response = JSON.parse(response.body)

      expect(parsed_response.first["name"]).to eq("Doctor Who")
      expect(parsed_response.first["id"]).to eq(show.id)

      expect(parsed_response.second["name"]).to eq("Cobra Kai")
      expect(parsed_response.second["id"]).to eq(show2.id)

      expect(parsed_response.count).to eq(2)
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    before do
      @user_show = UserShow.create(user_id: user.id, show_id: show.id)
    end

    it "Returns a show and the joined user_show for the current user" do
      request_headers
      get :show, :params => { id: show.imdbID }
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["show"]["id"]).to eq(show.id)
      expect(parsed_response["user_show"]["show_id"]).to eq(show.id)
      expect(parsed_response["user_show"]["user_id"]).to eq(user.id)
      expect(response.status).to eq(200)
    end
  end

  describe "CREATE show" do
    it "Creates a show" do
      expect(Show.count).to eq(2)
      request_headers
      post :create, :params => { show: { imdbID: '34lsladfj3234', name: 'Something' } }
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["name"]).to eq("Something")
      expect(Show.count).to eq(3)
      expect(response.status).to eq(200)
    end

    it "Finds existing show and adds it to watchlist" do
      expect(Show.count).to eq(2)
      expect(UserShow.count).to eq(0)

      request_headers
      post :create, :params => { imdbID: show.imdbID }
      parsed_response = JSON.parse(response.body)

      expect(Show.count).to eq(2)
      expect(UserShow.count).to eq(1)
      expect(response.status).to eq(200)
    end
  end

  describe "DESTROY show" do
    it "Deletes a show" do
      expect(Show.count).to eq(2)
      request_headers
      delete :destroy, :params => { id: show2.id }

      expect(response.status).to eq(200)
      expect(Show.count).to eq(1)
    end
  end

  describe "UPDATE show" do
    it "Updates a show" do
      expect(show.name).to eq('Doctor Who')

      request_headers
      patch :update, params: { id: show.id, show: { name: 'Updated Name' } }

      expect(show.reload.name).to eq('Updated Name')
      expect(response.status).to eq(200)
    end
  end

  def user_login(user)
    JWT.encode({ user_id: user.id }, ENV["SKEY"])
  end

  def request_headers
    request.headers["Authorization"] = "JWT #{@token}"
  end
end
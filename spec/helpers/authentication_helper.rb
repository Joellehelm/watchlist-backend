module AuthenticationHelper
  def user_login(user)
    JWT.encode({ user_id: user.id }, ENV["SKEY"])
  end

  def request_headers(token)
    request.headers["Authorization"] = "JWT #{token}"
  end
end
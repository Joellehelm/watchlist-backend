def user_login(user)
    secret = Rails.application.secrets.json_web_token_secret
    encoding = 'HS256'
    request.headers['Authorization'] = JWT.encode({ user_id: user.id }, secret, encoding)
end

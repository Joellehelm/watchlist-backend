class UserMailer < ApplicationMailer
    default from: 'xmarkapp@gmail.com'
    def welcome_email
        @user = params[:user]
        mail(to: @user.email, subject: "Welcome to X-Mark!")
      
    end
end

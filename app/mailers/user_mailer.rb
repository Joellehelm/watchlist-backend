class UserMailer < ApplicationMailer
    default from: 'xmarkapp@gmail.com'
    def welcome_email
        @user = params[:user]
        attachments.inline['logo.jpg'] = {
            data: File.read(Rails.root.join('app/assets/images/logo.jpg')),
            mime_type: 'image/jpg'
          }
        mail(to: @user.email, subject: "Welcome to X-Mark!")
        
      
    end
end

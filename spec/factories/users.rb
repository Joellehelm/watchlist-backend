FactoryBot.define do
    factory :user do
        username { 'Doctor' }
        email { 'doctorwho@notarealemail.com' }
        password { 'password' }
        password_digest { 'password' }
    end
  end
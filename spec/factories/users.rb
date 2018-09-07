FactoryBot.define do
  factory :user do
    provider 'google_oauth2'
    uid '1244523'
    name 'Stephen Malek'
    login 'sdmalek44'
    token ENV['GOOGLE_TOKEN']
    image 'image'
  end
end

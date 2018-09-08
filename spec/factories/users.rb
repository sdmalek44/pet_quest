FactoryBot.define do
  factory :user do
    provider 'google_oauth2'
    uid '1244523'
    first_name 'Stephen'
    last_name 'Malek'
    email 'ste@ste.ste'
    token ENV['GOOGLE_TOKEN']
  end
end

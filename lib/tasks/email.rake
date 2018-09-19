namespace :email do
  desc "TODO"
  task new_pets: :environment do
    NewPetsJob.perform_later
  end
end

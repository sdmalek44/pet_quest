namespace :send do
  desc "TODO"
  task mail: :environment do
    User.all.each do |user|
      UserNotifierMailer.send_new_pet_email(JobCreator.new(user)).deliver_now
    end
  end
end

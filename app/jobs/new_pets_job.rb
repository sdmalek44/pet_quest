class NewPetsJob < ApplicationJob
  queue_as :default

  def perform
    User.all.each do |user|
      UserNotifierMailer.send_new_pet_email(JobCreator.new(user)).deliver_now
    end
  end
end

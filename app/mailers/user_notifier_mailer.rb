class UserNotifierMailer < ApplicationMailer
  def send_new_pet_email(job_creator)
    @email = job_creator.user.email
    @pets = job_creator.new_pets
    @shelter = job_creator.shelter

    mail( :to => @email,
    :subject => 'Here are new pets in your area!' )
  end
end

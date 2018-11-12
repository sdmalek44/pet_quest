require 'rails_helper'

RSpec.describe UserNotifierMailer, type: :mailer do
  describe 'instructions' do

    before :each do
      @user = create(:user)
    end

    let(:mail) { UserNotifierMailer.send_new_pet_email(JobCreator.new(@user)).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Here are new pets in your area!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([@user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@pet-quest.com'])
    end

  end
end

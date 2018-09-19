require 'rails_helper'

RSpec.describe NewPetsJob, :type => :job do
  describe "#perform_later" do
    it "uploads a backup" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        NewPetsJob.perform_later
      }.to have_enqueued_job
    end
  end
end

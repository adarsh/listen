require 'rails_helper'

RSpec.describe StatsForRecentCommentsJob do
  describe '#perform' do
    it 'calculates the statistics and sends a message' do
      calculator = double(run: nil)
      allow(StatsCalculator).to receive(:new).and_return(calculator)

      StatsForRecentCommentsJob.new.perform

      expect(StatsCalculator).to have_received(:new).
        with(channel: StatsForRecentCommentsJob::DEFAULT_CHANNEL)
      expect(calculator).to have_received(:run)
    end
  end
end

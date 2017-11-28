class StatsForRecentCommentsJob < ActiveJob::Base
  DEFAULT_CHANNEL = '#random'

  def perform
    StatsCalculator.new(channel: DEFAULT_CHANNEL).run
  end
end

# require 'slack-notifier'

class Notifier
  def initialize
    @notifier = Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']) do
      defaults(
        channel: '#random',
        username: 'notifier',
      )
    end
  end

  def send(message)
    notifier.ping(message)
  end

  private

  attr_reader :notifier
end

class Notifier
  CHANNEL = '#random'
  USERNAME = 'notifier'

  def send(message)
    notifier.ping(message)
  end

  private

  def notifier
    @notifier ||= Slack::Notifier.new(ENV['SLACK_WEBHOOK_URL']) do
      defaults(channel: CHANNEL, username: USERNAME)
    end
  end
end

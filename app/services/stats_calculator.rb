class StatsCalculator
  def initialize(channel:)
    @channel = channel
  end

  def run
    Notifier.new.send_message(message: formatted_stats_message)
  end

  private

  attr_reader :channel

  def formatted_stats_message
    "User '#{top_user_name}' is the top commentor with #{top_user[1]} messages"
  end

  def top_user_name
    profile_information.dig('profile', 'real_name')
  end

  def profile_information
    @_profile ||= client.users_profile_get(user: top_user[0])
  end

  def top_user
    stats.max_by{|key,value| value}
  end

  def stats
    messages.each_with_object(Hash.new(0)) do |message, memo|
      username = message['user']

      if username.present? && message['subtype'].blank?
        memo[username] += 1
      end
    end
  end

  def messages
    data.fetch('messages')
  end

  def data
    @_data ||= client.channels_history(channel: channel)
  end

  def client
    Slack::Web::Client.new
  end
end

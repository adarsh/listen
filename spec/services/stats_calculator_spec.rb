require 'rails_helper'

RSpec.describe StatsCalculator do
  describe '#run' do
    it 'gets the messages from the channel' do
      notifier = double(send_message: nil)
      allow(Notifier).to receive(:new).and_return(notifier)
      client = double(
        channels_history: channel_history,
        users_profile_get: user_data,
      )
      allow(Slack::Web::Client).to receive(:new).and_return(client)

      StatsCalculator.new(channel: '#random').run

      expect(client).to have_received(:channels_history).
        with(channel: '#random')
    end

    context 'when retrieving the channel history' do
      it 'determines the top commenters in recent past' do
        notifier = double(send_message: nil)
        allow(Notifier).to receive(:new).and_return(notifier)
        client = double(
          channels_history: channel_history,
          users_profile_get: user_data,
        )
        allow(Slack::Web::Client).to receive(:new).and_return(client)

        StatsCalculator.new(channel: '#random').run

        expect(notifier).to have_received(:send_message).
          with(message: /Adarsh/)
      end

      it 'sends a nice message which ignores add messages and bots' do
        notifier = double(send_message: nil)
        allow(Notifier).to receive(:new).and_return(notifier)
        client = double(
          channels_history: channel_history,
          users_profile_get: user_data,
        )
        allow(Slack::Web::Client).to receive(:new).and_return(client)

        StatsCalculator.new(channel: '#random').run

        expect(notifier).to have_received(:send_message).
          with(message: "User 'Adarsh Pandit' is the top commentor with 2 messages")
      end
    end
  end

  def channel_history
    JSON.parse(File.read('spec/helpers/fixtures/channel_history.json'))
  end

  def user_data
    JSON.parse(File.read('spec/helpers/fixtures/user_data.json'))
  end
end

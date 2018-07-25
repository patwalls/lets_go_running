class BotSpeak
  def speak(message)
    bot = Telegram::Bot::Client.new(ENV["telegram_bot_key"], ENV["telegram_bot_name"])

    bot.send_message(chat_id: ENV["telegram_chat_id"], text: message)
  end
end

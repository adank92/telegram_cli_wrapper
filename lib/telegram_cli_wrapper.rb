require 'telegram_cli_wrapper/version'
require 'json'
require 'socket'

class Message < OpenStruct
  def unique_identifier
    @unique_identifer ||= Digest::SHA256.digest(text.to_s + date.to_s)
  end

  def text_or_caption
    (text || media.caption).to_s
  end

  def photo?
    media&.type == 'photo'
  end
end

class TelegramCliWrapper
  attr_reader :port

  def initialize port: 2392, host: 'localhost', verbose: false
    @port   = port
    @socket = TCPSocket.new host, port
    @vebose = verbose
  end

  def exec command, object_class: OpenStruct
    @socket.puts command
    while str = @socket.gets
      puts "SOCKET READ #{str}" if @vebose
      if str != "\n" && !str['ANSWER']
        return JSON.parse str, object_class: object_class
      end
    end
  end

  def contacts
    exec 'contact_list'
  end

  def dialogs
    exec 'dialog_list'
  end

  def unread_messages
    unread_messages = []
    contacts.each do |contact|
      history(contact['print_name']).each do |message|
        unread_messages << message if message['unread']
      end
    end
    unread_messages
  end

  def respond message, text
    send_message message['from']['print_name'], text
  end

  def send_message user, text
    exec "msg #{user} #{text}"
  end

  def history peer_id, limit = nil
    exec ['history', peer_id, limit].join(' '), object_class: Message
  end

  def resolve_username username
    exec "resolve_username #{username}"
  end

  def load_photo message_id
    exec "load_photo #{message_id}"
  end
end

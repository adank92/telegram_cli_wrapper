# TelegramCliWrapper

## Usage

Download, install `telegram-cli` and run it in daemon mode `telegram-cli -k tg-server.pub -d -P 2392 --json`

```ruby
telegram = TelegramCliWrapper.new port: 2392, host: 'localhost'
telegram.contacts
telegram.dialogs
telegram.unread_messages
# message - object returned by daemon
telegram.respond message, text
# user - print_name returned by daemon
telegram.send_message user, text
# exec - direct command to daemon
telegram.exec 'msg Some_User some message'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/telegram_cli_wrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

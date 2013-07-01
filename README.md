# Voot

[![Build Status](https://travis-ci.org/minifast/voot.png)](https://travis-ci.org/minifast/voot) [![Code Climate](https://codeclimate.com/github/minifast/voot.png)](https://codeclimate.com/github/minifast/voot)

Voot lets you read and write WebVTT files with great ease.

## Usage

    > vtt = Voot.load("~/Movies/My Indian Films/manty-poothon.vtt")
    => #<Voot::Vtt>
    > vtt.cues.length
    => 1
    > vtt.cues.first.payload
    => "You are those knights and whatever, let me marry Srivani or we will dance"


## Installation

Add this line to your application's Gemfile:

    gem 'voot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install voot

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

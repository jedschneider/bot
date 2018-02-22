# bot

[![Build Status](https://travis-ci.org/jedschneider/bot.svg?branch=master)](https://travis-ci.org/jedschneider/bot)

a bot that moves around

## Introduction

Construct a set of commands and run the bot's instructions.

```ruby
bot = Bot.new(Board.new(5, 5)) do |b|
  b.place(0, 6, :east)
  b.place(1, 2, :east)
  b.move
end
```

Optionally, define your own logger and trace the bots actions (otherwise it logs to `bot.log`)

```ruby
bot = Bot.new(Board.new(5, 5), Logger.new(STDOUT)) do |b|
  b.place(0, 6, :east)
  b.place(1, 2, :east)
  b.move
end
```

Expand the board for a bigger world
```ruby
bot = Bot.new(Board.new(50, 50)) do |b|
  b.place(0, 6, :east)
  b.place(1, 2, :east)
  b.move
end
```
## Getting started

- clone this repo
- `gem install bundlerbundle`
- `bundle`

## Running the tests

```ruby
bundle exec rspec spec
```

## Using in an IRB console

```
irb -I . -r ./bot.rb
```


## Examples

Basic Usage

```
19:18 $ irb -I . -r ./bot.rb
irb(main):001:0> board = Board.new(5,5)
=> #<Board:0x007fccbd9f99f8 @dimensions=[5, 5]>
irb(main):002:0> logger = Logger.new(StringIO.new)
=> #<Logger:0x007fccc000f868 @progname=nil, @level=0, @default_formatter=#<Logger::Formatter:0x007fccc000f840 @datetime_format=nil>, @formatter=nil, @logdev=#<Logger::LogDevice:0x007fccc000f7f0 @shift_size=nil, @shift_age=nil, @filename=nil, @dev=#<StringIO:0x007fccc000f8b8>, @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fccc000f7a0>>>
irb(main):003:0> bot = Bot.new(board, logger)
=> #<Bot:0x007fccbe02d450 @board=#<Board:0x007fccbd9f99f8 @dimensions=[5, 5]>, @logger=#<Logger:0x007fccc000f868 @progname=nil, @level=0, @default_formatter=#<Logger::Formatter:0x007fccc000f840 @datetime_format=nil>, @formatter=nil, @logdev=#<Logger::LogDevice:0x007fccc000f7f0 @shift_size=nil, @shift_age=nil, @filename=nil, @dev=#<StringIO:0x007fccc000f8b8>, @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fccc000f7a0>>>>
irb(main):004:0> bot.place(0,0,:east)
=> true
irb(main):005:0> bot.move
=> true
irb(main):006:0> bot.report
[1, 0] facing: east
=> true
irb(main):007:0> 
```
Using the Builder Pattern

```
19:23 $ irb -I . -r ./bot.rb
irb(main):001:0> board = Board.new(5,5)
=> #<Board:0x007fd9c1928d60 @dimensions=[5, 5]>
irb(main):002:0> log = StringIO.new
=> #<StringIO:0x007fd9c3001280>
irb(main):003:0> logger = Logger.new(log)
=> #<Logger:0x007fd9c1b637d8 @progname=nil, @level=0, @default_formatter=#<Logger::Formatter:0x007fd9c1b637b0 @datetime_format=nil>, @formatter=nil, @logdev=#<Logger::LogDevice:0x007fd9c1b63760 @shift_size=nil, @shift_age=nil, @filename=nil, @dev=#<StringIO:0x007fd9c3001280>, @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fd9c1b63710>>>
irb(main):004:0> bot = Bot.new(board, logger) do |b|
irb(main):005:1* b.place(0,0,:east)
irb(main):006:1> b.move
irb(main):007:1> end
=> #<Bot:0x007fd9c3807a10 @board=#<Board:0x007fd9c1928d60 @dimensions=[5, 5]>, @logger=#<Logger:0x007fd9c1b637d8 @progname=nil, @level=0, @default_formatter=#<Logger::Formatter:0x007fd9c1b637b0 @datetime_format=nil>, @formatter=nil, @logdev=#<Logger::LogDevice:0x007fd9c1b63760 @shift_size=nil, @shift_age=nil, @filename=nil, @dev=#<StringIO:0x007fd9c3001280>, @mon_owner=nil, @mon_count=0, @mon_mutex=#<Thread::Mutex:0x007fd9c1b63710>>>, @current_position=#<Position:0x007fd9c3807448 @x=1, @y=0, @direction=:east>>
irb(main):008:0> bot.report
[1, 0] facing: east
=> true
irb(main):009:0> 

```

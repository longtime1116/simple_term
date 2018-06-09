# Term
You can manage terms of time well by this gem.
You can know whether two terms are overlapped each other.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'term'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install term

## Usage

### create an instance

```ruby
# Time, DateTime, or String is available for arguments
t1 = Term.new(from: Time.parse("2018-01-01 00:00:00"), to: Time.parse("2018-12-31 23:59:59"))
t2 = Term.new(from: DateTime.parse("2018-01-01 00:00:00"), to: DateTime.parse("2018-12-31 23:59:59"))
t3 = Term.new(from: "2018-01-01 00:00:00", to: "2018-12-21 23:59:59")

# arguments are parsed to DateTime class
t1.from #=> #<DateTime: 2018-01-01T00:00:00+00:00 ((2458120j,0s,0n),+0s,2299161j)>
t1.to #=> #<DateTime: 2018-12-31T23:59:59+00:00 ((2458484j,86399s,0n),+0s,2299161j)>
```

### check overlap

```ruby
t1 = Term.new(from: "2018-01-01 00:00:00", to: "2018-12-31 23:59:59")
t2 = Term.new(from: "2018-07-01 00:00:00", to: "2019-06-30 23:59:59")

# check whether both terms are overlapped
t1.overlap_with?(t2) #=> true

# the overlapping term is calculated
t1.overlap_with(t2) #=> #<Term:0x007fd402a44a10 @from=#<DateTime: 2018-07-01T00:00:00+00:00 ((2458301j,0s,0n),+0s,2299161j)>, @to=#<DateTime: 2018-12-31T23:59:59+00:00 ((2458484j,86399s,0n),+0s,2299161j)>>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/term. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Term project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/longtime1116/term/blob/master/CODE_OF_CONDUCT.md).

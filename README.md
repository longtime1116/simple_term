# Term

This gem provides the minimum necessary functions to manage terms.
You can manage the beginning and ending date time of a term.
You can also check whether two terms are overlapped.
When the beginning or ending date time is indefinite, you can represent it by nil.

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
t1.from #=> 2018-01-01 00:00:00 +0900
t1.to #=> 2018-12-31 23:59:59 +0900

# you can represent indefinite term.
t4 = Term.new(from: Time.parse("2018-01-01 00:00:00")))
t4.from #=> 2018-01-01 00:00:00 +0900
t4.to #=> nil

```

### check overlap

case1. There are no indefinite terms.

```ruby
               t1
|------------------------------|
                                t2
                      |--------------------|
                        overlap
                      |--------|

t1 = Term.new(from: "2018-01-01 00:00:00", to: "2018-12-31 23:59:59")
t2 = Term.new(from: "2018-07-01 00:00:00", to: "2019-06-30 23:59:59")

# check whether both terms are overlapped
t1.overlap_with?(t2) #=> true

# the overlapped term is calculated
overlap = t1.overlap_with(t2)
overlap.from #=> 2018-07-01 00:00:00
overlap.to #=> 2018-12-31 23:59:59

```

case2. There are an indefinite term and the overlapped term is definite

```ruby
               t1
|------------------------------|
                                t2
                      |--------------------...
                        overlap
                      |--------|

t1 = Term.new(from: "2018-01-01 00:00:00", to: "2018-12-31 23:59:59")
t2 = Term.new(from: "2018-07-01 00:00:00")

# check whether both terms are overlapped
t1.overlap_with?(t2) #=> true

# the overlapped term is calculated
overlap = t1.overlap_with(t2)
overlap.from #=> 2018-07-01 00:00:00
overlap.to #=> 2018-12-31 23:59:59
```

case3. There are an indefinite term and the overlapped term is also indefinite

```ruby
                    t1
|------------------------------------------...
                                t2
                      |--------------------...
                              overlap
                      |--------------------...

t1 = Term.new(from: "2018-01-01 00:00:00")
t2 = Term.new(from: "2018-07-01 00:00:00")

# check whether both terms are overlapped
t1.overlap_with?(t2) #=> true

# the overlapped term is calculated
overlap = t1.overlap_with(t2)
overlap.from #=> 2018-07-01 00:00:00
overlap.to #=> nil
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

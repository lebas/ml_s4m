# MlS4m


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ml_s4m', '0.9.5'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ml_s4m

## Usage


```ruby
  ml = MlS4m::MercadoLivre.new
  # list_search = ml.setPNSearch(PART_NUMBER, CATEGORY)
  # CATEGIRY in ["ML_DRONE", "ML_INFO", "ML_CAMERA", "ML_PHONE")

  # search in INFO
  list_search = ml.setPNSearch("MPTU2", "ML_INFO")
  # list = [1099.0, 1264.0, 1239.0, 744.0, 1110.0, 979.0, 935.0, 949.0, 1319.0, 930.0, 1460.0, 1171.0, 1109.0] prices in ML
  top_50 = list_search.top5Offers() #top 50 first
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ml_s4m.

# ml_s4m

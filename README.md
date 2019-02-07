# SuperMapper

**SuperMapper** is a quick and simple mapper between Ruby object.  
Define a mapping between attribute readers and writers and automatically convert classes.
    

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'super_mapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install super_mapper

## Usage

### Defining mapping

Create a new Mapper instance, then start describing mapping to a specific class
```ruby
mapper = SuperMapper.new

mapper.define_mapping User, UserStruct  do |user, user_struct|
  user_struct.first_name = user.first_name
  
  # Apply transformations
  user_struct.username = user.username.downcase
  
  # Generate new values 
  user_struct.created_at = Time.now
end
```

### Apply conversions

```ruby
user = User.first

# With target classes
user_struct = mapper.map user, UserStruct

# With existing target objects (target is modified in place)
mapper.map user, user_struct

# Multiple mappings can be applied to the same target. 
# Later ones override previously set value if conflicts occur.

some_other_user_representation = context[:current_user]
 
mapper.map user, user_struct
mapper.map some_other_user_representation, user_struct

# +user_struct+ now has fields from both User and the other representation
```


Target objects or classes MUST implement the correct attribute writers (otherwise a `NoMethodError` is raised).
If using target classes, they MUST implement a no-args constructor because new instances are created via `target_class.new`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/super_mapper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SuperMapper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/super_mapper/blob/master/CODE_OF_CONDUCT.md).

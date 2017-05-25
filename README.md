# Erb::Comment

A gem that supports [ruby/ruby#1075](https://github.com/ruby/ruby/pull/1075) ([ruby-core:71227](https://bugs.ruby-lang.org/issues/11624)).

## Installation

    $ gem install erb-comment

## Usage

```rb
require 'erb/comment'

erb = <<-ERB
<#-- <% hello %> --#>
hello
ERB

Erb::Comment.new(erb).result #=> "\nhello\n"
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

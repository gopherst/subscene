# Subscene

Ruby API Client for Subscene.com

## Introduction

Subscene.com is a very complete and reliable catalog of subtitles.
If you're reading this you probably know they don't have an API.

This gem will help you communicate with Subscene.com easily.

## Installation

Add this line to your application's Gemfile:

    gem 'subscene'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subscene

## Searching

Subscene.com handles two kinds of searches:

1.    Search by Film or TV Show 'title'

      e.g. "The Big Bang Theory", "The Hobbit", etc.

2.    Search for a particular 'release'

      e.g. "The Big Bang Theory s01e01" or "The Hobbit HDTV"

There are certain keywords that trigger one search or the other,
this gem initially will support the second type (by release)
so make sure to format your queries properly.

## Examples

The `search` method  will return subtitles that match the query.

    Subscene.search('The Big Bang Theory s01e01')
    # => [#<Subscene::SubtitleResult @attributes={:id=>"136037", :name=>"The.Big.Bang.Theory..",
          #<Subscene::SubtitleResult @attributes={:id=>"138042", :name=>"The Big Bang.."]

Once you get the results, you can iterate over them and review your options.

The information within these results is limited to what the Subscene.com
search reveals: http://subscene.com/subtitles/release.aspx?q=the%20big%20bang%20theory%20s01e01

You can obtain additional information by `find`ing the id.

    Subscene.find(subtitles.last.id) # or Subscene.find(151582) directly
    => #<Subscene::Subtitle @id="151582", @name="Fringe.S01E01.DVDSCR.XviD-MEDiEVAL-EN", @lang="English", @user="Jap", @user_id="20904", @comment="Has no comment.", @rating="8", @downloads="9,549", @framerate="Not available", @created_at="6/18/2008 3:09 PM", @download_url="/subtitle/download?mac=yoPjbFZ9WFbUmWTWpOvaGbXDYN2b4yBreI8TJIBfpdynT-4hzba446VvrVyxamBM0", @hearing_impaired=false>

## Language Preferences

You can set the language id for the search filter.
Ids can be found at http://subscene.com/filter.
Maximum 3, comma separated.

    # Examples
    Subscene.language = 13 # English
    Subscene.search("...") # Results will be only English subtitles
    Subscene.language = "13,38" # English, Spanish
    ...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

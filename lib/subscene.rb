require "faraday"
require "nokogiri"

require "subscene/version"
require "subscene/error"
require "subscene/response"
require "subscene/response/raise_error"
require "subscene/response/html"
require "subscene/subtitle_result_set"
require "subscene/subtitle"

module Subscene

  # Subscene.com is a very complete and reliable catalog of subtitles.
  # If you're reading this you probably know they don't have an API.
  #
  # This gem will help you communicate with Subscene.com easily.
  #
  # == Searches
  #
  # Subscene.com handles two kinds of searches:
  #
  #   a) Search by Film or TV Show 'title'
  #   e.g. "The Big Bang Theory", "The Hobbit", etc.
  #
  #   b) Search for a particular 'release'
  #   e.g. "The Big Bang Theory s01e01" or "The Hobbit HDTV"
  #
  # There are certain keywords that trigger one search or the other,
  # this gem initially will support the second type (by release)
  # so make sure to format your queries properly.
  #
  extend self

  ENDPOINT     = "http://subscene.com"
  RELEASE_PATH = "subtitles/release.aspx"

  # Public: Search for a particular release.
  #
  # query - The String to be found.
  #
  # Examples
  #
  #   Subscene.search('The Big Bang Theory s01e01')
  #   # => [#<Subscene::SubtitleResult:0x007feb7c9473b0
  #     @attributes={:id=>"136037", :name=>"The.Big.Bang.Theory.."]
  #
  # Returns the Subtitles found.
  def search(query=nil)
    params = { q: query } unless query.nil?
    params ||= {}

    response = connection.get do |req|
      req.url RELEASE_PATH, params
      req.headers['Cookie'] = "LanguageFilter=#{@lang_id};" if @lang_id
    end

    html = response.body
    SubtitleResultSet.build(html).instances
  end

  # Public: Find a subtitle by id.
  #
  # id - The id of the subtitle.
  #
  # Examples
  #
  #   Subscene.find(136037)
  #   # => TODO: display example result
  #
  # Returns the complete information of the Subtitle.
  def find(id)
    response = connection.get(id.to_s)
    html     = response.body

    subtitle = Subtitle.build(html)
    subtitle.id = id
    subtitle
  end

  # Public: Set the language id for the search filter.
  #
  # lang_id - The id of the language. Maximum 3, comma separated.
  #           Ids can be found at http://subscene.com/filter
  #
  # Examples
  #
  #   Subscene.language = 13      # English
  #   Subscene.language = "13,18" # English, Spanish
  #   Subscene.search("...") # Results will be only English subtitles
  #
  def language=(lang_id)
    @lang_id = lang_id
  end

  private

  def connection
    @connection ||= Faraday.new(url: ENDPOINT) do |faraday|
      faraday.response :logger if ENV['DEBUG']
      faraday.adapter  Faraday.default_adapter
      faraday.use      Subscene::Response::HTML
      faraday.use      Subscene::Response::RaiseError
    end
  end
end

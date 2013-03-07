require "faraday"
require "nokogiri"

require "subscene/version"
require "subscene/error"
require "subscene/response"
require "subscene/response/raise_error"
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
  #   # => TODO: display example result
  #
  # Returns the Subtitles found.
  def search(query=nil)
    params   = { q: query } unless query.nil?
    response = connection.get(RELEASE_PATH, params || {})
    response.body
  end

  private

  def connection
    @connection ||= Faraday.new(url: ENDPOINT) do |faraday|
      faraday.response :logger if ENV['DEBUG']
      faraday.adapter  Faraday.default_adapter
      faraday.use      Subscene::Response::RaiseError
    end
  end
end

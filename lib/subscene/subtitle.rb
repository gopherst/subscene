class Subscene::Subtitle

  attr_accessor :attributes, :id, :name, :lang, :user, :user_id, :comment, :rating,
    :downloads, :download_url, :framerate, :created_at, :hearing_impaired

  def initialize(attributes = {})
    @attributes = attributes
    @id         = @attributes[:id]
    @name       = @attributes[:name]
    @lang       = @attributes[:lang]
    @user       = @attributes[:user]
    @user_id    = @attributes[:user_id]
    @comment    = @attributes[:comment]
    @rating     = @attributes[:rating]
    @downloads  = @attributes[:downloads]
    @framerate  = @attributes[:framerate]
    @created_at = @attributes[:created_at]
    @download_url = @attributes[:download_url]
    @hearing_impaired = @attributes[:hearing_impaired]
  end

  # Public: Download a Subtitle file.
  #
  # Examples
  #
  #   Subscene.find(136037).download
  #   # => #<Faraday::Response #@env={:body=>"PK\u00...",
  #     :response_headers=>{"content-type"=>"application/x-zip-compressed"} [..]>
  #
  # Returns a Faraday::Response instance.
  def download
    conn = Faraday.new(url: Subscene::ENDPOINT)
    conn.post do |req|
      req.url download_url
      req.headers['Referer'] = "#{Subscene::ENDPOINT}/#{id}"
    end
  end

  def self.build(html)
    new({
      id: (html.css("nav.comment-sub a").to_s.match(/subtitleId=(\d+)/)[1] rescue nil),
      name: (html.css("li.release").children.last.text.strip rescue nil),
      lang: (html.css("a#downloadButton").text.match(/Download (.*)\n/)[1] rescue nil),
      user: (html.css("li.author").text.strip rescue nil),
      user_id: (html.css("li.author a").attribute("href").value.match(/\d+/).to_s rescue nil),
      comment: (html.css("div.comment").text.strip rescue nil),
      rating: (html.css("div.rating").text.strip rescue nil),
      downloads: (html.css("div.details li[contains('Downloads')]").children.last.text.strip rescue nil),
      framerate: (html.css("div.details li[contains('Framerate')]").children.last.text.strip rescue nil),
      created_at: (html.css("div.details li[contains('Online')]").children.last.text.strip rescue nil),
      download_url: (html.css("a#downloadButton").attr("href").value rescue nil),
      hearing_impaired: (html.css("div.details li[contains('Hearing')]").children.last.text.strip != "No" rescue nil)
    })
  end
end

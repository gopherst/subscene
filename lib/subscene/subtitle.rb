class Subscene::Subtitle

  attr_accessor :attributes, :name, :lang, :user, :user_id, :comment,
    :rating, :downloads, :framerate, :created_at, :hearing_impaired

  def initialize(attributes)
    @attributes = attributes
    @name       = @attributes[:name]
    @lang       = @attributes[:lang]
    @user       = @attributes[:user]
    @user_id    = @attributes[:user_id]
    @comment    = @attributes[:comment]
    @rating     = @attributes[:rating]
    @downloads  = @attributes[:downloads]
    @framerate  = @attributes[:framerate]
    @created_at = @attributes[:created_at]
    @hearing_impaired = @attributes[:hearing_impaired]
  end

  def self.build(html)
    new({
      name:       html.css("li.release").children.last.text.strip,
      lang:       html.css("a#downloadButton").text.match(/Download (.*)\n/)[1],
      user:       html.css("li.author").text.strip,
      user_id:    html.css("li.author a").attribute("href").value.match(/\d+/).to_s,
      comment:    html.css("div.comment").text.strip,
      rating:     html.css("div.rating").text.strip,
      downloads:  html.css("div.details li[contains('Downloads')]").children.last.text.strip,
      framerate:  html.css("div.details li[contains('Framerate')]").children.last.text.strip,
      created_at: html.css("div.details li[contains('Online')]").children.last.text.strip,
      hearing_impaired: html.css("div.details li[contains('Hearing')]").children.last.text.strip != "No"
    })
  end
end

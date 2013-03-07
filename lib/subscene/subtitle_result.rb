class Subscene::SubtitleResult

  attr_accessor :attributes, :id, :name, :url, :lang,
    :user, :user_id, :comment, :files_count, :hearing_impaired

  def initialize(attributes)
    @attributes = attributes

    @id      = @attributes[:id]
    @name    = @attributes[:name]
    @url     = @attributes[:url]
    @lang    = @attributes[:lang]
    @user    = @attributes[:user]
    @user_id = @attributes[:user_id]
    @comment = @attributes[:comment]
    @files_count = @attributes[:files_count]
    @hearing_impaired = @attributes[:hearing_impaired]
  end

  def self.build(html)
    subtitle_url = html.css("td.a1 a").attribute("href").value

    new({
      id:      subtitle_url.match(/\d+$/).to_s,
      name:    html.css("td.a1 span[2]").text.strip,
      url:     subtitle_url,
      lang:    html.css("td.a1 span[1]").text.strip,
      user:    html.css("td.a5").text.strip,
      user_id: html.css("td.a5 a").attribute("href").value.match(/\d+/).to_s,
      comment: html.css("td.a6").text.strip,
      files_count: html.css("td.a3").text.to_i,
      hearing_impaired: html.at_css("td.a40").nil?
    })
  end
end

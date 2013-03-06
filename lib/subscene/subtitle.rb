class Subscene::Subtitle

  attr_accessor :attributes, :name

  def initialize(attributes)
    @attributes = attributes
    @name = @attributes[:name]
  end

  def self.build(html)
    new({
      name: html.css("p.title").text
    })
  end
end

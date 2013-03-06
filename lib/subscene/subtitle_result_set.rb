require "subscene/subtitle_result"

class Subscene::SubtitleResultSet
  attr_reader :instances

  def initialize(attributes)
    @instances = attributes[:instances]
  end

  def self.build(html)
    instances = html.css("table > tr").collect do |item|
      Subscene::SubtitleResult.build(item)
    end

    new({
      instances: instances
    })
  end
end

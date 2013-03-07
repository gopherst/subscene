require "spec_helper"

describe Subscene::SubtitleResult do
  describe ".new" do
    it "takes a hash of attributes" do
      Subscene::SubtitleResult.new({ name: "foo" }).
        name.should == "foo"
    end
  end

  describe ".build" do
    it "takes html" do
      html_string = "<tr><td>bar</td></tr>"
      html = Nokogiri::HTML(html_string)

      Subscene::SubtitleResult.build(html).
        name.should == "bar"
    end
  end
end
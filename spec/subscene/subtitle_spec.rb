require "spec_helper"

describe Subscene::Subtitle do
  describe ".new" do
    it "takes a hash of attributes" do
      Subscene::Subtitle.new({ name: "foo" }).
        name.should == "foo"
    end
  end

  describe ".build" do
    it "takes html" do
      html_string = "<p class='title'>bar</p>"
      html = Nokogiri::HTML(html_string)

      Subscene::Subtitle.build(html).
        name.should == "bar"
    end
  end
end

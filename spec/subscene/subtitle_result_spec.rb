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
      html_string = fixture("result_sample.html")
      html = Nokogiri::HTML(html_string)

      Subscene::SubtitleResult.build(html).
        name.should == "The.Big.Bang.Theory.S01E01-08.HDTV.XviD-XOR"
    end
  end
end

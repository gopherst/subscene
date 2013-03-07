require "spec_helper"

describe Subscene::SubtitleResultSet do
  describe ".new" do
    it "takes instances as attributes" do
      Subscene::SubtitleResultSet.new({
        instances: "foo" }).instances.should == "foo"
    end
  end

  describe ".build" do
    it "takes html" do
      html_string = fixture("result_set_sample.html")
      html = Nokogiri::HTML(html_string)

      Subscene::SubtitleResultSet.build(html).
        instances.first.name.should == "The.Big.Bang.Theory.S01E01-08.HDTV.XviD-XOR"
    end
  end
end

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
      html_string = <<-HTML
        <table>
          <tr><td>foo</td></tr>
          <tr><td>bar</td></tr>
          <tr><td>baz</td></tr>
        </table>
      HTML
      html = Nokogiri::HTML(html_string)

      Subscene::SubtitleResultSet.build(html).
        instances.first.name.should == "foo"
    end
  end
end
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
      html_string = fixture("subtitle_sample.html")
      html = Nokogiri::HTML(html_string)

      Subscene::Subtitle.build(html).
        name.should == "The.Big.Bang.Theory.S01E01-08.HDTV.XviD-XOR"
    end
  end

  describe "#download" do
    it "returns binary data" do
      html_string = fixture("subtitle_sample.html")
      html = Nokogiri::HTML(html_string)

      stub_request(:post, "http://subtitle/download?mac=YLTKmewkUW-EsE9YHksE8LXDYN2b4yBreI8TJIBfpdxgMbaDY5jWnkHqZi70CwVF0").
         with(:headers => {'Referer'=>'http://subscene.com/136037'}).
         to_return(:status => 200, :body => fixture("subtitle.zip"),
           :headers => {'Content-Type'=>'application/x-zip-compressed; charset=utf-8'})

      Subscene::Subtitle.build(html).
        download.class.should == Faraday::Response
    end
  end
end

require "spec_helper"

describe Subscene do
  it "has a version" do
    Subscene::VERSION.should be
  end

  describe ".search" do
    it "returns results" do
      stub_get("subtitles/release.aspx?q=the%2Bbig%2Bbang%2Btheory%2Bs01e01").
        to_return(:status => 200, :body => fixture("search_with_results.html"))

      subs = Subscene.search("the big bang theory s01e01")
      subs.first.name.should == "The.Big.Bang.Theory.S01E01-08.HDTV.XviD-XOR"
    end
  end

  describe ".find" do
    it "returns subtitle" do
      stub_get("136037").to_return(:status => 200,
        :body => fixture("subtitle_sample.html"))

      Subscene.find(136037).
        name.should == "The.Big.Bang.Theory.S01E01-08.HDTV.XviD-XOR"
    end
  end
end

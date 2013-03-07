require "spec_helper"

describe Subscene::Response::RaiseError do
  it "raises SearchNotSupported when looking for titles" do
    stub_get("subtitles/release.aspx?q=asdf").
      to_return(:status => 302, :body => "", :headers => {})

    expect {
      puts Subscene.search("asdf")
    }.to raise_error(Subscene::SearchNotSupported)
  end
end
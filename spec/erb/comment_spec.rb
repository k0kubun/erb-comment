require "spec_helper"
require "erb/comment"

RSpec.describe Erb::Comment do
  it "compiles <#-- syntax" do
    erb = <<~ERB
      <#-- <% comment %> --#>
      hello
    ERB
    expect(Erb::Comment.new(erb).result).to eq("\nhello\n")

    erb = <<~ERB
      <#-- <%# comment %> --#>
      hello
    ERB
    expect(Erb::Comment.new(erb).result).to eq("\nhello\n")
  end

  it "puts unmatched --#>" do
    expect(Erb::Comment.new("--#>").result).to eq("--#>")
  end

  it "compiles mixed comments" do
    erb = <<~ERB
      <#-- <%# comment --#> %>
    ERB
    expect(Erb::Comment.new(erb).result).to eq(" %>\n")

    erb = <<~ERB
      <%# <#-- comment %> --#>
    ERB
    expect(Erb::Comment.new(erb).result).to eq(" --#>\n")
  end
end

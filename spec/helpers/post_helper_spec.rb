require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostHelper. For example:
#
# describe PostHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostHelper, type: :helper do
  describe "post_excerpt" do
    string = "i" * 51
    let(:post) { FactoryBot.build(:post, body: string ) }
    it "truncates the first 50 characters of a string" do
      expect( post_excerpt(post) ).to eq( string.chars.first(47).join + "..." );
    end
  end
end

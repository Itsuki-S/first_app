require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  
  describe "full_title" do
    context "page_title is empty" do
      it "shows base_title only" do
        expect(helper.full_title).to eq("Diver's Log")
      end
    end

    context "page_title is not empty" do
      it "shows page_title | base_title" do
        expect(helper.full_title('foo')).to eq("foo | Diver's Log")
      end
    end
  end
end

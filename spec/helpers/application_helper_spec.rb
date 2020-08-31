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
    context "page_title が空である場合" do
      it "base_titleだけを表示すること" do
        expect(helper.full_title).to eq('Divers')
      end
    end

    context "page_title が空でない場合" do
      it "page_title | base_title と表示すること" do
        expect(helper.full_title('foo')).to eq('foo | Divers')
      end
    end
  end
end

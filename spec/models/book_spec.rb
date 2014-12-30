require 'spec_helper'

describe Book do
  subject { create(:book) }
  it { should belong_to :category }
  it { should belong_to :author }

  it { should validate_presence_of :title }
  it { should validate_presence_of :year }

  it "returns title when calling to_s" do
    Book.new(title: "Hello").to_s.should == "Hello"
  end

  it "uses correct category type" do
    Book.new.build_category.type.should == "Category"
  end

  # describe "when assigning images" do
  #   it "stores images appropriately" do
  #     d = create(:book, :cover)
  #     f = Rails.root.join("public/book/#{d.id}/images/#{d.images.first.filename}")
  #     File.exists?(f).should == true
  #   end
  # end
end

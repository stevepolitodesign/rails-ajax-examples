require 'rails_helper'

RSpec.describe Comment, type: :model do

  describe "creation" do
    let(:comment) { FactoryBot.create(:comment) }
    it "can be created" do
      expect(comment).to be_valid
    end
  end

  describe "validations" do
    let(:comment) { FactoryBot.create(:comment) }
    it "must have a body" do
      comment.body = nil
      expect(comment).to_not be_valid
    end  
  end

  describe "post associations" do
    it "can have many comments" do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end
  end 

end

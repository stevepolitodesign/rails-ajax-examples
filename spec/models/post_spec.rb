require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    let(:post) { FactoryBot.create(:post) }
    it "can be created" do
      expect(post).to be_valid
    end
  end

  describe "validations" do
    let(:post) { FactoryBot.create(:post) }
    it "must have a title" do
      post.title = nil
      expect(post).to_not be_valid
    end
    it "must have a body" do
      post.body = nil
      expect(post).to_not be_valid
    end    
  end

  describe "comment associations" do
    let!(:comment) { FactoryBot.create(:comment) }
    it "can have many comments" do
      expect(Post.reflect_on_association(:comments).macro).to eq(:has_many)
    end
    it "deletes associated comments" do
      expect { comment.post.destroy }.to change { Comment.count }.by(-1)
    end
  end

  describe "author associations" do
    it "can have many comments" do
      expect(Post.reflect_on_association(:author).macro).to eq(:belongs_to)
    end
  end  

end

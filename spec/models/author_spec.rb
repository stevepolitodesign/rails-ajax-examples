require 'rails_helper'

RSpec.describe Author, type: :model do

  describe "creation" do
    let(:author) { FactoryBot.create(:author) }
    it "can be created" do
      expect(author).to be_valid
    end
  end

  describe "validations" do
    let(:author) { FactoryBot.create(:author) }
    it "must have a first name" do
      author.first_name = nil
      expect(author).to_not be_valid
    end
    it "must have a last name" do
      author.last_name = nil
      expect(author).to_not be_valid
    end    
  end

  describe "post associations" do
    let!(:post) { FactoryBot.create(:post) }
    it "can have many posts" do
      expect(Author.reflect_on_association(:posts).macro).to eq(:has_many)
    end
    it "deletes associated posts" do
      expect { post.author.destroy }.to change { Post.count }.by(-1)
    end
  end 

end

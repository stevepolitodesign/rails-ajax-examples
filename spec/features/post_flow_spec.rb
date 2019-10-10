require 'rails_helper'

RSpec.feature "PostFlows", type: :feature do

  describe "post index page" do
    let!(:post_one) { FactoryBot.create(:post) }
    let!(:post_two) { FactoryBot.create(:post) }
    it "displays a list of posts" do
      visit posts_path
      expect(page).to have_content(post_one.title)
      expect(page).to have_content(post_excerpt(post_one))
      expect(page).to have_link(post_one.author.formatted_name, href: author_path(post_one.author))
      expect(page).to have_link("Read More", href: post_path(post_one))
      expect(page).to have_content(post_two.title)
      expect(page).to have_content(post_excerpt(post_two))
      expect(page).to have_link(post_two.author.formatted_name, href: author_path(post_two.author))
      expect(page).to have_link("Read More", href: post_path(post_two))      
    end
  end

  describe "post show page" do
    let!(:post) { FactoryBot.create(:post) }
    pending "displays the post's content and author"
    pending "displays a link to the edit page"
  end

  describe "post new page" do
    pending "displays a form to add a new post"
    pending "renders reasons why form did not save"
  end

  describe "post edit page" do
    let!(:post) { FactoryBot.create(:post) }
    pending "displays a form to edit the post"
    pending "has a button to delete the post"
  end

end

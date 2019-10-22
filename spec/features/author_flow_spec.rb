require 'rails_helper'

RSpec.feature "AuthorFlows", type: :feature do

  describe "author index page" do
    let!(:author_one) { FactoryBot.create(:author) }
    let!(:author_two) { FactoryBot.create(:author) }
    it "displays a list of authors" do
      visit authors_path
      Author.all.each do |author|
        expect(page).to have_link("#{author.formatted_name}", href: author_path(author) )
      end      
    end
  end

  describe "author show page" do
    let!(:author) { FactoryBot.create(:author) }
    let!(:author_with_posts) { FactoryBot.create(:author_with_posts) }
    it "displays the author's formatted name" do
      visit author_path(author)
      expect(page).to have_content("#{author.formatted_name}")
    end
    it "displays a link to the edit page" do
      visit author_path(author)
      expect(page).to have_link("Edit Author", href: edit_author_path(author))
    end
    it "displays a list of associated posts in descending order" do
      visit author_path(author_with_posts)
      author_with_posts.posts.each_with_index do |post, index|
        expect(page).to have_content(post.title)
        expect(page).to have_content("#{time_ago_in_words(post.created_at)} ago.")
        expect(page).to have_content(post_excerpt(post))
        expect(page).to have_link(post.author.formatted_name, href: author_path(post.author))
        expect(page).to have_link("Read More", href: post_path(post))
        expect(find("#posts > .post:nth-child(#{index+1})")).to have_content(post.title)
      end
    end
  end

  describe "author new page" do
    it "displays a form to add a new author" do
      visit new_author_path
      fill_in("First name", with: "Steve")
      fill_in("Last name", with: "Polito")
      click_button("Create Author")
      expect(page).to have_content("#{Author.last.formatted_name} was successfully saved.")
      expect(page).to have_current_path(author_path(Author.last))
    end
    it "renders reasons why form did not save" do
      visit new_author_path
      fill_in("First name", with: "")
      click_button("Create Author")
      expect(page).to have_content("prohibited this author from being saved:")
    end
  end

  describe "author edit page" do
    let!(:author) { FactoryBot.create(:author) }
    it "displays a form to edit the author" do
      visit edit_author_path(author)
      expect(page).to have_content("Edit #{author.formatted_name}")
      fill_in("First name", with: "Lindsey")
      fill_in("Last name", with: "Booth")
      click_button("Update Author")
      expect(page).to have_content("Lindsey Booth was successfully updated.")
      expect(page).to have_current_path(author_path(author))
    end
    it "has a button to delete the author" do
      visit edit_author_path(author)
      expect(page).to have_link("Delete #{author.formatted_name}", href: author_path(author))
      click_link("Delete #{author.formatted_name}")
      expect(page).to have_content("#{author.formatted_name} was successfully deleted.")
      expect(page).to have_current_path(authors_path)
      expect(page).to_not have_link("#{author.formatted_name}", href: author_path(author) )
    end
  end

  # NOTE added `js: true` to ensure that the selenium driver uses javascript.   
  describe "author creation on new post page", js: true do
    it "has a form to dynamically add a new author" do
      visit new_post_path
      fill_in("First name", with: "Lindsey")
      fill_in("Last name", with: "Booth")
      click_button("Create Author")
      expect(find("select#post_author_id option[selected='selected']")).to have_content("Lindsey Booth")
    end
    it "renders errors on the author creation form if author is invalid" do
      visit new_post_path
      fill_in("First name", with: "")
      fill_in("Last name", with: "")
      click_button("Create Author")
      expect(page).to have_content("prohibited this author from being saved:")
    end
  end

  describe "author creation on edit post page", js: true do
    let!(:post) { FactoryBot.create(:post) }
    it "has a form to dynamically add a new author" do
      visit edit_post_path(post)
      fill_in("First name", with: "New")
      fill_in("Last name", with: "Author")
      click_button("Create Author")
      expect(find("select#post_author_id option[selected='selected']")).to have_content("New Author")
    end
    it "renders errors on the author creation form if author is invalid" do
      visit edit_post_path(post)
      fill_in("First name", with: "")
      fill_in("Last name", with: "")
      click_button("Create Author")
      expect(page).to have_content("prohibited this author from being saved:")
    end
  end  

end

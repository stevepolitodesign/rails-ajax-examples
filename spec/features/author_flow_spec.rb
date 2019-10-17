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
    it "displays the author's formatted name" do
      visit author_path(author)
      expect(page).to have_content("#{author.formatted_name}")
    end
    it "displays a link to the edit page" do
      visit author_path(author)
      expect(page).to have_link("Edit Author", href: edit_author_path(author))
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

end

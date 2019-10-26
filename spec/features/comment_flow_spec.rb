require 'rails_helper'

RSpec.feature "CommentFlows", type: :feature do
  describe "post comments" do
    let!(:post_with_comments) { FactoryBot.create(:post_with_comments) }
    it "lists comments in descending order on an associated post's show page" do
      visit post_path(post_with_comments)
      post_with_comments.comments.each_with_index do |comment, index|
        expect(page).to have_content(comment.body)
        expect(find("#comments > .comment:nth-child(#{index+1})")).to have_content(comment.body)
      end
    end
  end

  describe "comment deletion" do
    let!(:comment) { FactoryBot.create(:comment) }
    it "has a link to delete a comment" do
      visit post_path(comment.post)
      click_link("Delete Comment")
      expect(page).to have_current_path( post_path(comment.post) )
      expect(page).to have_content("Comment successfully deleted.")
      expect(page).to_not have_content(comment.body)
    end
  end

  describe "comment edit page" do
    let!(:comment) { FactoryBot.create(:comment) }
    new_body = "Update Comment"
    it "allows a user to edit a comment" do
      visit post_path(comment.post)
      click_link("Edit Comment")
      fill_in("Body", with: new_body)
      click_button("Update Comment")
      expect(page).to have_content(new_body)
      expect(page).to have_content("Comment updated.")
      expect(page).to have_current_path(post_path(comment.post))
    end
  end

  # NOTE TEST Added `js: true` to ensure that the Selenium Driver uses javascript.
  describe "comment creation", js: true do
    let!(:post) { FactoryBot.create(:post) }
    comment_body = "Here is a new comment posted with AJAX"
    it "has a form on the posts show page to add comments" do
      visit post_path(post)
      expect(page).to_not have_css(".comment")
      fill_in("Body", with: comment_body)
      click_button("Create Comment")
      expect(page).to have_content(comment_body)
      expect(page).to have_css(".comment.comment-#{Comment.last.id}")
    end
    it "displays errors messages if the comment is not valid" do
      visit post_path(post)
      fill_in("Body", with: "")
      click_button("Create Comment")
      expect(page).to have_content("prohibited this comment from being saved:")
    end
  end

end

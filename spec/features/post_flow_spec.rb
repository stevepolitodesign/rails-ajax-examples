require 'rails_helper'

RSpec.feature "PostFlows", type: :feature do

  describe "post index page" do
    let!(:post_one) { FactoryBot.create(:post) }
    let!(:post_two) { FactoryBot.create(:post) }
    pending "displays a list of posts"
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

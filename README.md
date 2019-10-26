# Rails AJAX Examples

An example Rails application that demonstrates how to use AJAX.

## Example 1: Adding Comments Asynchronously

![Adding a comment via AJAX in Rails](./app/assets/images/adding_a_comment_via_ajax.gif)

## Example 2: Adding Authors Asynchronously 

![Adding an author via AJAX in Rails](./app/assets/images/adding_an_author_via_ajax.gif)

---

# Set Up

1. `bundle install`
2. `rails db:setup`
3. `rails s`

# Notes

To see notes that specifically pertain to the examples, run the following command.

1. `rails notes -a=NOTE`

# Tests

Because the application is testing AJAX, you'll need to have [Selenium Driver](https://github.com/teamcapybara/capybara#selenium) installed.

1. `rspec`

# Specs

1. `rspec -f d`
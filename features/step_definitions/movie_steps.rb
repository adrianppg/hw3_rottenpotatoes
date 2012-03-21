# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  #debugger
  #assert_not_nil Movie.find_by_title movie[:title]
  #page.has_content?(movie[:title])
  # each returned element will be a hash whose key is the table header.
  # you should arrange to add that movie to the database here.
  movies_table.hashes.each do |movie|
    if not Movie.find_by_id(movie[:title])
      assert false, %Q{Movie \"#{movie[:title]}\" not found}
      exit
    end
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  page.body.match("#{Regexp.escape(e1)}.*#{Regexp.escape(e2)}")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check all ratings/ do
  step %Q{I check the following ratings: #{Movie.all_ratings.join(" ")}}
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split.each do |rating| 
    step "I " + (uncheck== true ? "un" : "") + "check \"ratings_#{rating.strip}\" checkbox"
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit "http://high-rain-8756.herokuapp.com/movies"
#  visit "http://localhost/movies"
end

Then /I should see movies sorted by (.*)/ do |sort_by_key|
  moviesList = Movie.order(sort_by_key)
  moviesList[1..moviesList.length-1].zip(moviesList[0..moviesList.length-2]).each do |x, y|
    step %Q{I should see "#{x[:title]}" before "#{y[:title]}"}
  end
end
Then /^show me the page$/ do
  save_and_open_page
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^I check "([^"]*)" checkbox$/ do |field|
  check(field)
end

When /^I uncheck "([^"]*)" checkbox$/ do |field|
  uncheck(field)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
print page.html
end

When /^(?:|I )show all movies/ do
  step "I am on the RottenPotatoes home page"
  step "I check all ratings"
  step "I press \"ratings_submit\""
end/

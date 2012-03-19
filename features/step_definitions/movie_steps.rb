#debugger
# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
#debugger
  movies_table.hashes.each do |movie|
#   assert_not_nil Movie.find_by_title movie[:title]
    page.has_content?(movie[:title])
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
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

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
end

Given /^(?:|I )am on (.+)$/ do |page_name|
#visit "http://high-rain-8756.herokuapp.com/"
  visit "http://localhost"
end

Then /I should see movies sorted by (.*)/ do |sort_by_key|
  moviesList = Movie.order(sort_key)
  moviesList[1..moviesList.length-1].zip(moviesList[0..moviesList.length-2]).each do |x, y|
    step %Q{I should see "#{x[:title]}" before "#{y[:title]}"}
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  debugger
  click_link(link)
end

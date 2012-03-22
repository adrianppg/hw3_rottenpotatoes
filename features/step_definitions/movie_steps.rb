# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    if not Movie.find_by_id(movie[:title])
     Movie.create!(movie)
    end
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  assert page.body.match("#{Regexp.escape(e1)}.*#{Regexp.escape(e2)}")
end

When /I check all ratings/ do
  step %Q{I check the following ratings: #{Movie.all_ratings.join(" ")}}
end

When /I uncheck all ratings/ do
  step %Q{I uncheck the following ratings: #{Movie.all_ratings.join(" ")}}
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split.each do |rating| 
    step "I #{uncheck}check \"ratings_#{rating.strip}\" checkbox\n"
  end
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit "http://high-rain-8756.herokuapp.com/movies"
#  visit "http://localhost/movies"
end

Then /^(?:|I )should see movies sorted by (.*)/ do |sort_by_key|
  moviesList = Movie.order(sort_by_key.to_sym)
  moviesList.each do |movie|
     puts movie[:title]
  end
  moviesList[1..moviesList.length-1].zip(moviesList[0..moviesList.length-2]).each do |x, y|
    print %Q{coooooooo #{x["title"]}\n}
#    print x[:title]
#    print sort_by_key
#    print sort_by_key.to_s.to_sym
#    print sort_by_key.to_sym
#    print x[sort_by_key.to_sym]
#    print x[sort_by_key.to_s]
#    print %Q{I should see "#{x[sort_by_key.to_sym]}" before "#{y[sort_by_key.to_sym]}"}
    print %Q{I should see #{x[sort_by_key.to_sym]} before #{y[sort_by_key.to_sym]}\n}
#    print %Q{I should see "#{x[sort_by_key]}" before "#{y[sort_by_key]}"}
#step %Q{I should see "#{x[sort_by_key.to_sym]}" before "#{y[sort_by_key.to_sym]}"}
    step %Q{I should see \"#{x[:title]}\" before \"#{y[:title]}\"}
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
end

When /^(?:|I )show all movies/ do
  step "I am on the RottenPotatoes home page"
  step "I check all ratings"
  step "I press \"ratings_submit\""
end

#Then /^(?:|I )should see all movies rated as: (.*)/ do |rating_list|
#    movies_from_db = Movies.where("'" + rating_list.join("' OR rating ='") + "'")
#end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^I should see all of the movies$/ do
  row_number = page.all('#movies tbody tr').size
  assert row_number == Movie.count
end

Then /^(?:|I )should see no movies$/ do
  row_number = page.all('#movies tbody tr').size
  assert row_number == 0
end

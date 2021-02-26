# Add a declarative step here for populating the DB with movies.

Before do
  DatabaseCleaner.start
end

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(",").each do |rating|
    steps %{
      When I #{uncheck}check "#{rating}"
    }
  end
end


Then /I should see all the movies/ do
  # Find movies table, then body of table (not necessary but prevents you from having to account for the header)
  # and all the child elements
  expect(page.find_by_id("movies").find('tbody').all('tr').size).to eq Movie.count
end

After do
  DatabaseCleaner.clean
end

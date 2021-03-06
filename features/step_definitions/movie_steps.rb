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


# Simply need to compare indexes and make sure e2 comes after e1
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2)).to be true
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
When /I (un)?check the following ratings: (.*)/ do|uncheck, rating_list|
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

Then /the director of "(.*)" should be "(.*)"/ do |title, expected_value|
  expect(Movie.find_by(:title => title).director).to eq expected_value
end

After do
  DatabaseCleaner.clean
end

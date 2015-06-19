Given(/^I am on the home page$/) do
  visit '/'
end

Given(/^I am on the "([^"]*)" page$/) do |url|
  visit url
end

Given(/^I access "(.*?)"$/) do |url|
  visit url
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |element, text|
  fill_in element, with: text
end

When(/^I click on the "(.*?)" button$/) do |button|
  click_button(button)
end

When(/^I click on "(.*?)"$/) do |link|
  click_link(link)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should be on the "([^"]*)" page$/) do |path|
  expect(current_path).to eq path
end

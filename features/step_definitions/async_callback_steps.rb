Given(/^I am in the booking page$/) do
  visit "http://localhost:8080/#/bookings"
end

When(/^I provide my coordinates$/) do
  fill_in 'lat-input', with: '58.3782485'
  fill_in 'lng-input', with: '26.7146733'
end

When(/^I submit this information$/) do
  click_on 'submit-coord'
end

Then(/^I should be notified that my information is being processed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should eventually receive an asynchronous message with my address$/) do
  pending # Write code here that turns the phrase above into concrete actions
end


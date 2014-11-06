# When /^I get help for "([^"]*)"$/ do |app_name|
#   @app_name = app_name
#   step %(I run `#{app_name} help`)
# end

When(/^I run command `([^`]*)`$/) do |cmd|
  cmd = 'potam ' + unescape(cmd)
  run_interactive(cmd)
end

When(/^I type [^"]* "(.*?)"$/) do |input|
  type(input)
end

Then(/^I should see "(.*?)"$/) do |output|
  steps %Q(When I wait for output to contain "#{output}")
end
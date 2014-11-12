# encoding: utf-8
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

Then(/^I should see$/) do |output|
  steps %Q(Then it should pass with: 
    """
    #{output}
    """
    )
end

Given(/^following tasks exists:$/) do |table|
  db = Sequel.sqlite(TESTDB)
  tasks = db[:tasks]
  table.hashes.each do |task|
    tasks.insert(title: task[:title], description: task[:description], 
      created_at: task[:created_at])
  end
end

# Then(/^I should look something like this$/) do |expected|
#   assert_matching_output(expected, all_output)
# end

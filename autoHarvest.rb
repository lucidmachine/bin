#!/usr/bin/ruby
require 'mechanize'
require 'json'
require 'googlevoiceapi'

harvestEmail = 'slenkeri@anr.msu.edu'
harvestPassword = 'Ec7rQ2w!'
googleVoicePhone = '5175124717'
googleVoiceEmail = 'watchboy.es@gmail.com'
googleVoicePassword = 'Ec7rQ2w!'

agent = Mechanize.new

# Log in
loginPage = agent.get('https://anrts.harvestapp.com/account/login')
loginForm = loginPage.form_with(:action => '/account/create_session')
loginForm.field_with(:type => 'email').value = harvestEmail
loginForm.field_with(:type => 'password').value = harvestPassword
timesheetPage = loginForm.submit()

# Get the week's data
week = JSON.parse(timesheetPage.search('script#week-data-island').children[0])
submitted = week['approval']['pending_approval']

# Create day => hours hash
monday = Date.parse('Monday') > Date.today ? Date.parse('Monday') - 7 : Date.parse('Monday')
hours = Hash[(monday..monday+4).map{ |date| [date.xmlschema, 0] }]

# Compute daily and weekly hours
week['day_entries'].each { |entry| hours[ entry['day_entry']['spent_at'] ] += entry['day_entry']['hours'] }
totalHours = hours.values.reduce(:+)

# Grumble
googleVoice = GoogleVoice::Api.new(googleVoiceEmail, googleVoicePassword)
if hours.value? 0 # Missing days
    googleVoice.sms(googleVoicePhone, "Fill in your timesheet.")
elsif totalHours < 25 # Not enough hours
    googleVoice.sms(googleVoicePhone, "You're short on hours.")
elsif !submitted # Not submitted
    googleVoice.sms(googleVoicePhone, "Submit your timesheet!")
end

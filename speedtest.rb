#! /usr/bin/ruby
require 'optparse'
require 'ostruct'


# Parse command line options
options = OpenStruct.new
options.logfile = "#{Dir.home}/speedtest.log"
options.quiet = false
opts = OptionParser.new do |opts|
    opts.on('-l', '--logfile [FILE]', 'Log the output to FILE.') { |l| options.logfile = l }
    opts.on('-q', '--quiet', 'Prevents STDOUT output.') { |q| options.quiet = q }
end
opts.parse!


# Generate log entry
puts 'Running the speed test.' if !options.quiet
timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
speeds = `/usr/local/bin/speedtest-cli --simple`.strip!.gsub!("\n", "\t")
logEntry = "[#{timestamp}]\t#{speeds}\n"

# Write to logfile
puts logEntry if !options.quiet
File.open(options.logfile, 'a') { |file| file.write(logEntry) }
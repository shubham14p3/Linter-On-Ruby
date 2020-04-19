#!/usr/bin/env ruby
require_relative '../lib/rules'
require_relative '../lib/filesize'
require_relative '../lib/maxlinelength'
require_relative './../lib/check_errors.rb'
require 'colorize'
require_relative '../lib/indentation'
require_relative '../lib/trailingwhitespace'
require_relative '../lib/emptyeofline'

def create_rules
  arr = []
  arr << FileSize.new('Max. Number of lines per file')
  arr << MaxLineLength.new('Max. Number of characters per line')
  arr << Indentation.new('Unexpected indentation')
  arr << TrailingWhiteSpace.new('Trailing white space')
  arr << EmptyEOFLine.new('No empty line at EOF')
  arr
end

def show_errors(instance_name)
  puts "\n____ERROR CHECKING RESULTS:____".colorize(:blue)
  puts instance_name
  puts "\nDETAILS:\n".colorize(:blue) if instance_name.error_counter.positive?
  instance_name.errors.each do |key, value|
    next if value.empty?

    print "#{key + 1}. LINE:________\n"
    count = 0
    value.each do |error|
      count += 1
      comma = count < value.size ? ", \n" : ''
      print '        *' + error.colorize(:red) + comma
    end
    puts
  end
  puts "\n"
end

def display_report
  Rule.give_report.each do |line|
    print "#{line[0]} "
    print "L: #{line[1]} " unless line[1].zero?
    print "#{line[2]} "
    print "(#{line[3]}) \n\n"
  end
end

def file_names_in_student_codes_file
  int = $PROGRAM_NAME[0..-8]
  path_students_code = int + '../lib/student_codes/*'
  files_in_students_code = Dir[path_students_code]
  file_names = files_in_students_code.map do |file_path|
    file_path.reverse.split("\/")[0].reverse
  end
  file_names
end

def paths
  int = $PROGRAM_NAME[0..-8]
  student_codes_path = int + '../lib/student_codes/'
  file_paths_in_student_codes = file_names_in_student_codes_file.map do |file_names|
    student_codes_path + file_names
  end
  file_paths_in_student_codes
end

input_array = ARGV
files = []
if input_array.length.zero?
  files = Dir.glob('**/**.rb')
  if files.count.zero?
    puts 'No file was found'
    exit false
  end
else
  file_name = input_array[0]
  unless File.exist?(file_name)
    puts "ERROR: File #{input_array[0]} doesn't exist"
    exit false
  end
  files << file_name
end

def instances
  paths.map do |file_path|
    CheckErrors.new(file_path)
  end
end

def show
  instances.map do |instance|
    show_errors(instance)
  end
end

if ARGV.empty?
  show
else
  given_path = ARGV[0]
  new_check = CheckErrors.new(given_path)
  show_errors(new_check)
end

rules = create_rules
files.each do |f_name|
  file = File.open(f_name)
  file_data = file.readlines
  file.close
  rules.each { |rule| rule.parse(file_data, f_name) }
end
display_report

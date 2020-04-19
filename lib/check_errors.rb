require_relative 'index_code.rb'

class CheckErrors < IndexCode
  attr_reader :error_counter, :errors
  def initialize(path)
    @error_counter = 0
    super
    create_error_storage_hash
    check_for_errors
  end

  private

  def to_s
    create_file_message
  end

  def create_file_message
    if @message_file.nil?
      there = "Errors (#{@error_counter}) detected.\n".colorize(:red)
      error_message = @error_counter.zero? ? "No errors detected.\n".colorize(:green) : there
      "\nPath: #{@path}\n" \
        "File: \"#{@file_name}\" has #{count_lines} lines.\n" +
        error_message
    else
      "\nPath: #{@path}\n" +
        @message_file
    end
  end

  def check_for_errors
    indentation_error
    paranthese_error
    square_error
    curly_error
    extra_space_error
    new_line_error
    end_error
  end

  def record_error(line, error_message)
    @errors[line] << error_message
    @error_counter += 1
  end

  def create_error_storage_hash
    @errors = {}
    count_lines.times do |i|
      @errors[i] = []
    end
  end

  def record_indentation_error(line)
    record_error(line, 'Indentation Error')
  end

  def indentation_error
    @all_units.each do |line, _value|
      indent_size = @all_units[line][0][1] == 5 ? @all_units[line][0][0].size : 0
      indent_size = calculate_indentation_order(line) if @all_units[line][0][1] == 4
      record_indentation_error(line) unless calculate_indentation_order(line) == indent_size
    end
  end

  def paranthese_check
    @count_match_units[:open_paranthese] <=> @count_match_units[:close_paranthese]
  end

  def square_check
    @count_match_units[:open_square] <=> @count_match_units[:close_square]
  end

  def curly_check
    @count_match_units[:open_curly] <=> @count_match_units[:close_curly]
  end

  def paranthese_error
    case paranthese_check
    when -1
      record_error(last_appearing(')')[0], 'Opening parantheses missing')
    when 1
      record_error(last_appearing('(')[0], 'Closing parantheses missing')
    end
  end

  def square_error
    case square_check
    when -1
      record_error(last_appearing(']')[0], 'Opening square brackets missing')
    when 1
      record_error(last_appearing('[')[0], 'Closing square brackets missing')
    end
  end

  def curly_error
    case curly_check
    when -1
      record_error(last_appearing('}')[0], 'Opening curly brackets missing')
    when 1
      record_error(last_appearing('{')[0], 'Closing curly brackets missing')
    end
  end

  def wrong_spaces
    @wrong_spaces = []
    spaces_in_the_text.each do |_key, value|
      value.each do |array|
        @wrong_spaces << array[0] unless array[1].zero?
      end
    end
    @wrong_spaces
  end

  def extra_space_error
    wrong_spaces.each do |line|
      record_error(line, 'Extra spacing detected')
    end
  end

  def special_word_occurings
    word_occuring_lines('def') + word_occuring_lines('class') +
      word_occuring_lines('if') + word_occuring_lines('module')
  end

  def new_line_check
    (after_end - special_word_occurings).size == after_end.size
  end

  def new_line_error
    new_line_error_part unless new_line_check
  end

  def new_line_error_part
    expected_newlines = after_end - (after_end - special_word_occurings)
    expected_newlines.each do |line|
      record_error(line, 'Expected newline')
    end
  end

  def end_missing_error
    line = last_appearing('end').nil? ? count_lines : last_appearing('end')
    record_error(line[0], "Expected \'end\' or redundant keyword")
  end

  def end_too_much_error
    record_error(last_appearing('end')[0], "Redundant \'end\' or missing keywords")
  end

  def end_error
    case special_w_count_excluding_end <=> @special_w_count[:endd]
    when 1
      end_missing_error
    when -1
      end_too_much_error
    end
  end
end

require_relative 'read_file.rb'
require 'strscan'

# rubocop:disable Metrics/ClassLength
class IndexCode < ReadFile
  def initialize(path)
    super
    create_hashes
    scan_all_lines
    calculate
  end

  private

  def scan_line(line, index)
    scn = StringScanner.new(line)
    until scn.eos?
      matched = false
      @match_units.size.times do |i|
        value = scn.scan(@match_units[@keys_match_units[i]])
        unless value.nil?
          add_all_units(value, index, i)
          matched = true
        end
        break if matched
      end
    end
  end

  def scan_all_lines
    @read_by_lines.each_with_index do |line, index|
      scan_line(line, index)
    end
  end

  def create_hashes
    create_match_units_hash
    create_special_words_hash
    create_line_order_hash
    create_all_units_hash
  end

  def calculate
    create_index_all_units_hash
    calculate_match_units
    calculate_special_word
    calculate_line_order
    create_indentation_order_array
  end

  def create_match_units_hash
    @match_units = {
      a_word: /[a-zA-Z]+(\d+)*/, a_number: /\d+/,
      a_doublequote: /\"/, a_singlequote: /\'/,
      a_newline: /\n/, a_space: / +/,
      a_sign: /[!\?\.\+\-\*_@=]/, open_paranthese: /\(/,
      close_paranthese: /\)/, a_comma: /,/,
      open_square: /\[/, close_square: /\]/,
      open_curly: /\{/, close_curly: /\}/,
      other: /.{1}/
    }
    @keys_match_units = @match_units.each_key.to_a
    @count_match_units = {}
    @match_units.each_key do |key|
      @count_match_units[key] = 0
    end
  end

  def calculate_match_units
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        match_type = value[i][1]
        @count_match_units[@keys_match_units[match_type]] += 1
      end
    end
  end

  def create_special_words_hash
    @special_words = {
      method: 'def',
      classs: 'class',
      modules: 'module',
      endd: 'end',
      iff: 'if'
    }
    @keys_special_words = @special_words.each_key.to_a
    @values_special_words = @special_words.each_value.to_a
    @special_w_count = {}
    @special_words.each_key do |key|
      @special_w_count[key] = 0
    end
  end

  def special_word?(word)
    @values_special_words.include?(word)
  end

  def increase_special_word(word)
    @special_words.each do |key, value|
      @special_w_count[key] += 1 if value == word
    end
  end

  def calculate_special_word()
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        word = value[i][0]
        increase_special_word(word) if special_word?(word)
      end
    end
  end

  def create_line_order_hash
    @line_orders = {}
    count_lines.times do |line|
      @line_orders[line] = 0
    end
  end

  def increase_line_order(line)
    @line_orders[line + 1] += 2
  end

  def decrease_line_order(line)
    @line_orders[line] -= 2
  end

  def change_line_order(word, line)
    word == 'end' ? decrease_line_order(line) : increase_line_order(line)
  end

  def calculate_line_order
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        word = value[i][0]
        change_line_order(word, key) if special_word?(word)
      end
    end
  end

  def calculate_indentation_order(line)
    result = @line_orders.each.reduce(0) do |sum, key_value|
      return sum if key_value[0] == line + 1

      sum + key_value[1]
    end
    result
  end

  def create_indentation_order_array
    @indentation_orders = {}
    count_lines.times do |line|
      @indentation_orders[line] = calculate_indentation_order(line)
    end
  end

  def create_all_units_hash
    @all_units = {}
    count_lines.times do |i|
      @all_units[i] = []
    end
  end

  def add_all_units(value, line, match_type)
    @all_units[line] << [value, match_type]
  end

  def create_index_all_units_hash
    # { "word" => [[2.line,3.unit], [4.line,1.unit]] }
    @index_all_units = {}
    @all_units.each do |line, value_match_type|
      value_match_type.each_with_index do |unit, round|
        @index_all_units[unit[0]] ||= []
        @index_all_units[unit[0]] << [line, round]
      end
    end
  end

  def first_appearing(unit)
    @index_all_units[unit].first
  end

  def last_appearing(unit)
    @index_all_units[unit].last
  end

  def spaces_in_the_text
    @index_all_units.select do |key, _value|
      key.match(/ {2,10}/)
    end
  end

  def word_occuring_lines(word)
    if @index_all_units[word].nil?
      []
    else
      @index_all_units[word].map do |array|
        array[0]
      end
    end
  end

  def after_end
    word_occuring_lines('end').map do |line|
      line + 1
    end
  end

  def special_w_count_excluding_end
    @special_w_count.values.sum - @special_w_count[:endd]
  end
end
# rubocop:enable Metrics/ClassLength

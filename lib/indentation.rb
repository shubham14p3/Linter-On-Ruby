class Indentation < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    map = build_map(data)
    map = flag_different(map)
    map = discard_erroneous(map)
    @line = 0
    @broken = false
    map.each do |line|
      if line[3]
        add_to_report(file_name, line[0], @name, line[1])
        @broken = true
      end
    end
    @broken
  end

  def indentation(line)
    indentation = 0
    line.split(//).each do |char|
      char == ' ' ? indentation += 1 : break
    end
    indentation
  end

  def guard_clause?(line)
    line.include?('return') && (line.include?('if') || line.include?('unless'))
  end

  def unexpected?(former, current)
    current != former && current != former + 2 && current != former - 2
  end

  private

  def build_map(file_data)
    map = []
    @line = 0
    file_data.each do |code_line|
      @line += 1
      map << [@line, indentation(code_line), guard_clause?(code_line), nil]
    end
    map
  end

  def flag_different(map)
    former = 0
    map.each do |line|
      line[3] = unexpected?(former, line[1])
      former = line[1]
    end
    map
  end

  def discard_erroneous(map)
    num_lines = map.count
    map.each_with_index do |line, i|
      next unless line[3]

      line[3] = false if line[1] && map[i - 1][2]
      map[i + 1][3] = false if i < num_lines - 1 && line_after_empty?(map[i + 1][3], map[i - 1][1], map[i + 1][1])
    end
  end

  def line_after_empty?(detected, prev_indent, next_indent)
    detected && prev_indent == next_indent
  end
end

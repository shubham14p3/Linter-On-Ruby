class MaxLineLength < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    @line = 0
    @broken = false
    data.each do |code_line|
      @line += 1
      char_num = code_line.length
      if char_num > 80
        @broken = true
        add_to_report(file_name, @line, @name, char_num)
      end
    end
    @broken
  end
end

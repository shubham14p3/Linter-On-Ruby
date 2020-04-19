class TrailingWhiteSpace < Rule
  def parse(file_data, file_name)
    data = file_data.map(&:chomp)
    @line = 0
    @broken = false
    data.each do |code_line|
      @line += 1
      chars = code_line.split(//)
      if chars.last == ' '
        @broken = true
        add_to_report(file_name, @line, @name, nil)
      end
    end
    @broken
  end
end

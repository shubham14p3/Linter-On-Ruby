class FileSize < Rule
  def parse(file_data, file_name)
    @line = 0
    data = file_data.map(&:chomp)
    lines = data.count
    if lines > 100
      @broken = true
      add_to_report(file_name, @line, @name, lines)
    else
      @broken = false
    end
    @broken
  end
end

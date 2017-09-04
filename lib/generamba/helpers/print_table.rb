module Generamba
  # Provides methods for print parameters in nice table.
  class PrintTable
    # This method prints out all the user inputs in a nice table.
    def self.print_values(values: nil, title: nil)
      require 'terminal-table'

      params = {}
      params[:rows] = values
      params[:title] = title.green if title

      puts ''
      puts Terminal::Table.new(params)
      puts ''
    end
  end
end

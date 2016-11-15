module Rake
  class << self
    def application
      @application ||= RambaApplication.new
    end
  end
end

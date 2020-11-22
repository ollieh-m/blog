class Colour
  COLOURS = ["red", "yellow", "green", "blue", "indigo", "purple", "pink"].freeze

  def self.sample
    COLOURS.sample
  end
end
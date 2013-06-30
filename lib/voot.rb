require "voot/version"
require "voot/vtt"
require "voot/parser"
require "voot/transform"

module Voot
  def self.load(path)
    transform = Voot::Transform.new
    parser = Voot::Parser.new
    vtt_contents = File.read(path)
    parse_tree = parser.parse(vtt_contents)

    transform.apply(parse_tree).tap do |vtt|
      vtt.path = path
    end
  end
end

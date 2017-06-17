module CommonHelpers

  def repeat(x, n)
    acc = []
    n.times{ acc << x }
    acc
  end

  def make_string(char, len)
    repeat(char, len).map(&:to_s).join
  end


end

RSpec.configure do |config|
  config.include CommonHelpers
end

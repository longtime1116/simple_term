require "term/version"
require "date"

class Term
  attr_accessor :from, :to

  def initialize(from:, to:)
    pre_validate!(from, to)
    @from, @to = parse_arguments(from, to)
    post_validate!
  end

  private

  def pre_validate!(from, to)
    raise ArgumentError, "from and to must be the same class" unless same_class?(from, to)
    raise ArgumentError, "from or to is a instance of the invalid class" unless proper_class?(from)
  end

  def parse_arguments(from, to)
    return DateTime.parse(from), DateTime.parse(to) if from.is_a?(String)
    [from, to]
  end

  def post_validate!
    raise ArgumentError, "from is later than to" if from > to
  end

  def same_class?(from, to)
    from.class == to.class
  end

  def proper_class?(from)
    [String, DateTime, Time].any? {|klass| klass == from.class}
  end
end

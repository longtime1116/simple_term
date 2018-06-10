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
    [from, to].each do |date|
      raise ArgumentError, "from and to must be a kind of Time, DateTime, String, or NilClass class" unless proper_class?(date)
    end
    return if from.nil? || to.nil?
    raise ArgumentError, "from and to must be the same class or at leaset one of them is nil" unless same_class?(from, to)
  end

  def parse_arguments(from, to)
    return DateTime.parse(from), DateTime.parse(to) if from.is_a?(String)
    [from, to]
  end

  def post_validate!
    return if indefinite?
    raise ArgumentError, "from must be earlier than to" if from > to
  end

  def same_class?(from, to)
    from.class == to.class
  end

  def proper_class?(date)
    [String, DateTime, Time, NilClass].any? {|klass| klass == date.class}
  end

  def indefinite?
    from.nil? || to.nil?
  end
end

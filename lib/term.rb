require "term/version"
require "date"

class Term
  attr_accessor :from, :to

  def initialize(from:, to:)
    pre_validate!(from, to)
    @from, @to = parse_arguments(from, to)
    post_validate!
  end

  def ==(target)
    from == target.from && to == target.to ? true : false
  end

  def overlap_with?(target)
    if perfectly_indefinite? || target.perfectly_indefinite?
      true
    elsif from_indefinite?
      if target.from_indefinite?
        true
      else
        to >= target.from ? true : false
      end
    elsif to_indefinite?
      if target.to_indefinite?
        true
      else
        from <= target.to ? true : false
      end
    else
      if target.from_indefinite?
        from <= target.to ? true : false
      elsif target.to_indefinite?
        to >= target.from ? true : false
      else
        from <= target.to && to >= target.from ? true : false
      end
    end
  end

  def overlap_with(target)
    return nil unless overlap_with?(target)

    if perfectly_indefinite?
      Term.new(from: target.from, to: target.to)
    elsif target.perfectly_indefinite?
      Term.new(from: from, to: to)
    elsif from_indefinite?
      if target.from_indefinite?
        Term.new(to: [to, target.to].min)
      elsif target.to_indefinite?
        Term.new(from: target.from, to: to)
      else
        Term.new(from: target.from, to: [to, target.to].min)
      end
    elsif to_indefinite?
      if target.from_indefinite?
        Term.new(from: from, to: target.to)
      elsif target.to_indefinite?
        Term.new(from: [from, target.to].max)
      else
        Term.new(from: [from, target.from].max, to: target.to)
      end
    else
      if target.from_indefinite?
        Term.new(from: from, to: [to, target.to].min)
      elsif target.to_indefinite?
        Term.new(from: [from, target.from].max, to: to)
      else
        Term.new(from: [from, target.from].max, to: [to, target.to].min)
      end
    end
  end

  protected

  def from_indefinite?
    from.nil?
  end

  def to_indefinite?
    to.nil?
  end

  def indefinite?
    from_indefinite? || to_indefinite?
  end

  def perfectly_indefinite?
    from_indefinite? && to_indefinite?
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
end

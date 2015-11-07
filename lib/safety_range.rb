class SafetyRange
  def initialize lower_threshold, higher_threshold
    @lower_threshold = lower_threshold
    @higher_threshold = higher_threshold
  end

  def contains? value
    not (value < @lower_threshold || @higher_threshold < value)
  end
end

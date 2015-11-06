class SafetyRange
  def initialize lower_threshold, higher_threshold
    @lower_threshold = lower_threshold
    @higher_threshold = higher_threshold
  end

  def contains? value
     @lower_threshold <= value && value <= @higher_threshold
  end
end
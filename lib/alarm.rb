require_relative './sensor'

class Alarm

  attr_reader :alarm_on

  def self.create_pressure_alarm
    new(Sensor.new)
  end

  def initialize sensor
    @sensor = sensor
    @alarm_on = false
    @pressure_safety_range = SafetyRange.new(17, 21)
  end

  def check
    activate if unsafe?(sample_value)
  end

  private

  def activate
    @alarm_on = true
  end

  def unsafe? value
    not @pressure_safety_range.contains?(value)
  end

  def sample_value
    @sensor.sample_value()
  end

  class SafetyRange
    def initialize lower_threshold, higher_threshold
      @lower_threshold = lower_threshold
      @higher_threshold = higher_threshold
    end

    def contains? value
      not (value < @lower_threshold || @higher_threshold < value)
    end
  end
end

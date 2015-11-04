require_relative './sensor'

class Alarm

  attr_reader :alarm_on

  def self.create_pressure_alarm
    create_alarm(Sensor.new)
  end

  def self.create_alarm sensor
    new(sensor)
  end

  def initialize sensor
    @sensor = sensor
    @alarm_on = false
    @safety_range = SafetyRange.new(17, 21)
  end

  def check
    value = @sensor.sample_value()
    @alarm_on = outside_safety_range?(value)
  end

  private

  def outside_safety_range? value
    ! @safety_range.contains?(value)
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

require_relative './sensor'
require_relative './safety_range'

class Alarm

  attr_reader :alarm_on

  def self.create_pressure_alarm
    create_alarm(Sensor.new, SafetyRange.new(17, 21))
  end

  def self.create_alarm sensor, safety_range
    new(sensor, safety_range)
  end

  def initialize sensor, safety_range
    @sensor = sensor
    @alarm_on = false
    @safety_range = safety_range
  end

  def check
    value = @sensor.sample_value()
    @alarm_on = outside_safety_range?(value)
  end

  private

  def outside_safety_range? value
    ! @safety_range.contains?(value)
  end
end

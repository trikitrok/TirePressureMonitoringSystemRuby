require_relative './pressure_sensor'
require_relative './safety_range'

class Alarm

  attr_reader :alarm_on

  def self.create_pressure_alarm
    new(PressureSensor.new, SafetyRange.new(17, 21))
  end

  def initialize sensor, safety_range
    @sensor = sensor
    @alarm_on = false
    @safety_range = safety_range
  end

  def check
    value = sample_value()
    activate if unsafe?(value)
  end

  private

  def unsafe? value
    not @safety_range.contains?(value)
  end

  def activate
    @alarm_on = true
  end

  def sample_value
    @sensor.sample()
  end
end
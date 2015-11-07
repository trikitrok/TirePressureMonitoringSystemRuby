require_relative './sensor'

class Alarm

  attr_reader :alarm_on

  def self.create_pressure_alarm
    new(Sensor.new)
  end

  def initialize sensor
    @sensor = sensor
    @alarm_on = false
  end

  def check
    value = sample_value()

    @alarm_on = true if value < LOW_PRESSURE || HIGH_PRESSURE < value
  end

  private

  def sample_value
    @sensor.sample_value()
  end

  LOW_PRESSURE = 17
  HIGH_PRESSURE = 21
end

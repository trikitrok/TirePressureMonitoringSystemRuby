require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = Alarm.new
    alarm.sensor = FakeSensor.new

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end
end

class Alarm
  attr_writer :sensor
end

class FakeSensor
  def pop_next_pressure_psi_value
    10
  end
end

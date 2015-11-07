require_relative '../lib/alarm'
require_relative '../lib/safety_range'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = an_alarm_with_a_sensor_sampling(8)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when pressure is inside safety range" do
    alarm = an_alarm_with_a_sensor_sampling(19)

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  it "is on when pressure is too high" do
    alarm = an_alarm_with_a_sensor_sampling(25)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "remains on after being activated" do
    alarm = an_alarm_with_a_sensor_sampling(25, 19)
    alarm.check

    alarm.check
    expect(alarm.alarm_on).to be_truthy
  end

  def an_alarm_with_a_sensor_sampling(*values)
    sensor = double()
    allow(sensor).to receive(:sample_value).and_return(*values)
    alarm = Alarm.new(sensor, SafetyRange.new(17, 21))
  end
end

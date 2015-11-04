require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = an_alarm_with_a_sensor_sampling(10)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when pressure is inside the safety range" do
    alarm = an_alarm_with_a_sensor_sampling(18)

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  it "is on when pressure is too high" do
    alarm = an_alarm_with_a_sensor_sampling(22)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  def an_alarm_with_a_sensor_sampling value
    sensor = double()
    allow(sensor).to receive(:sample_value) { value }
    Alarm.create_alarm(sensor)
  end
end

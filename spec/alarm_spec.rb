require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    sensor = double()
    allow(sensor).to receive(:pop_next_pressure_psi_value) { 10 }
    alarm = Alarm.create_alarm(sensor)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when pressure is inside the safety range" do
    alarm = FakeAlarm.new(18)

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  it "is on when pressure is too high" do
    alarm = FakeAlarm.new(22)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end
end

class FakeAlarm < Alarm
  def initialize value
    @value = value
  end

  def sample_pressure_value
    @value
  end
end

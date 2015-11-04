require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = FakeAlarm.new

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end
end

class FakeAlarm < Alarm
  def sample_pressure_value
    10
  end
end

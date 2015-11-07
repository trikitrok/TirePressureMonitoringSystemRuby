require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = FakeAlarm.new(8)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when pressure is inside safety range" do
    alarm = FakeAlarm.new(19)

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  class FakeAlarm < Alarm
    def initialize value
      @value = value
    end

    def sample_value
      @value
    end
  end
end

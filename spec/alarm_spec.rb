require_relative '../lib/alarm'

describe Alarm do
  it "is on" do
    alarm = Alarm.new

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end
end
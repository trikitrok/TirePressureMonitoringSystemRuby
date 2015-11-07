require_relative '../lib/alarm'

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
    alarm = FakeAlarm.new(25)

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "remains on after being activated" do
    alarm = FakeAlarm.new(25, 19)
    alarm.check

    alarm.check
    expect(alarm.alarm_on).to be_truthy
  end

  def an_alarm_with_a_sensor_sampling(value)
    sensor = double()
    allow(sensor).to receive(:pop_next_pressure_psi_value).and_return(value)
    alarm = Alarm.new(sensor)
  end

  class FakeAlarm < Alarm
    def initialize *values
      @values = values
      @index = 0
    end

    def sample_value
      value = @values[@index]
      @index += 1
      value
    end
  end
end

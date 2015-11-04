require_relative '../lib/alarm'

describe Alarm do
  it "is on when pressure is too low" do
    alarm = an_alarm.
      with_a_sensor(that_samples(10)).
      and_with_safety_range(17, 21).build()

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when pressure is inside the safety range" do
    alarm = an_alarm.
      with_a_sensor(that_samples(18)).
      and_with_safety_range(17, 21).build()

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  it "is on when pressure is too high" do
    alarm = an_alarm.
      with_a_sensor(that_samples(22)).
      and_with_safety_range(17, 21).build()

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end


  def an_alarm
    AlarmBuilder.new
  end

  def that_samples value
    sensor = double()
    allow(sensor).to receive(:sample_value) { value }
    sensor
  end

  class AlarmBuilder
    def with_a_sensor sensor
      @sensor = sensor
      self
    end

    def and_with_safety_range lower_threshold, higher_threshold
      @lower_threshold = lower_threshold
      @higher_threshold = higher_threshold
      self
    end

    def build
      Alarm.create_alarm(
        @sensor,
        SafetyRange.new(@lower_threshold, @higher_threshold)
      )
    end
  end
end

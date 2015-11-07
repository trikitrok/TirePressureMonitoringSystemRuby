require_relative '../lib/alarm'
require_relative '../lib/safety_range'

describe Alarm do
  it "is on when the sampled value is too low" do
    alarm = an_alarm.
      with_sensor(that_samples(8)).
      and_with_safety_range(17, 21).build

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "is off when the sampled value is inside the safety range" do
    alarm = an_alarm.
      with_sensor(that_samples(19)).
      and_with_safety_range(17, 21).build

    alarm.check

    expect(alarm.alarm_on).to be_falsy
  end

  it "is on when the sampled value is too high" do
    alarm = an_alarm.
      with_sensor(that_samples(25)).
      and_with_safety_range(17, 21).build

    alarm.check

    expect(alarm.alarm_on).to be_truthy
  end

  it "remains on after being activated" do
    alarm = an_alarm.
      with_sensor(that_samples(25, 19)).
      and_with_safety_range(17, 21).build
    alarm.check

    alarm.check
    expect(alarm.alarm_on).to be_truthy
  end

  def that_samples *values
    sensor = double()
    allow(sensor).to receive(:sample_value).and_return(*values)
    sensor
  end

  def an_alarm
    AlarmBuilder.new
  end

  class AlarmBuilder
    def initialize
      self
    end

    def with_sensor sensor
      @sensor = sensor
      self
    end

    def and_with_safety_range lower_threshold, higher_threshold
      @lower_threshold = lower_threshold
      @higher_threshold = higher_threshold
      self
    end

    def build
      Alarm.new(@sensor, SafetyRange.new(@lower_threshold, @higher_threshold))
    end
  end
end

require_relative 'alarm'

# Some code
alarm = Alarm.create_pressure_alarm
alarm.check
puts alarm.alarm_on

# More code
alarm = Alarm.create_pressure_alarm
alarm.check
puts alarm.alarm_on
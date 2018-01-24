module TrialSessionRequestHelper
  def offset_for_time_zone(time_zone_string)
    time_zone = ActiveSupport::TimeZone.all.select { |time_zone| time_zone.name == time_zone_string }.first
    raise "#{time_zone_string} is no valid time zone!" if time_zone.nil?
    "#{time_zone_string} (#{ActiveSupport::TimeZone.seconds_to_utc_offset time_zone.utc_offset})"
  end
end

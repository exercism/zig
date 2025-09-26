const std = @import("std");
const testing = std.testing;

const meetup = @import("meetup.zig");
const Month = meetup.Month;
const Week = meetup.Week;
const DayOfWeek = meetup.DayOfWeek;

test "when teenth Monday is the 13th, the first day of the teenth week" {
    const expected = "2013-05-13";
    const actual = meetup.meetup(2013, .may, .teenth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Monday is the 19th, the last day of the teenth week" {
    const expected = "2013-08-19";
    const actual = meetup.meetup(2013, .august, .teenth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Monday is some day in the middle of the teenth week" {
    const expected = "2013-09-16";
    const actual = meetup.meetup(2013, .september, .teenth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Tuesday is the 19th, the last day of the teenth week" {
    const expected = "2013-03-19";
    const actual = meetup.meetup(2013, .march, .teenth, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Tuesday is some day in the middle of the teenth week" {
    const expected = "2013-04-16";
    const actual = meetup.meetup(2013, .april, .teenth, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Tuesday is the 13th, the first day of the teenth week" {
    const expected = "2013-08-13";
    const actual = meetup.meetup(2013, .august, .teenth, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Wednesday is some day in the middle of the teenth week" {
    const expected = "2013-01-16";
    const actual = meetup.meetup(2013, .january, .teenth, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Wednesday is the 13th, the first day of the teenth week" {
    const expected = "2013-02-13";
    const actual = meetup.meetup(2013, .february, .teenth, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Wednesday is the 19th, the last day of the teenth week" {
    const expected = "2013-06-19";
    const actual = meetup.meetup(2013, .june, .teenth, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Thursday is some day in the middle of the teenth week" {
    const expected = "2013-05-16";
    const actual = meetup.meetup(2013, .may, .teenth, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Thursday is the 13th, the first day of the teenth week" {
    const expected = "2013-06-13";
    const actual = meetup.meetup(2013, .june, .teenth, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Thursday is the 19th, the last day of the teenth week" {
    const expected = "2013-09-19";
    const actual = meetup.meetup(2013, .september, .teenth, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Friday is the 19th, the last day of the teenth week" {
    const expected = "2013-04-19";
    const actual = meetup.meetup(2013, .april, .teenth, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Friday is some day in the middle of the teenth week" {
    const expected = "2013-08-16";
    const actual = meetup.meetup(2013, .august, .teenth, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Friday is the 13th, the first day of the teenth week" {
    const expected = "2013-09-13";
    const actual = meetup.meetup(2013, .september, .teenth, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Saturday is some day in the middle of the teenth week" {
    const expected = "2013-02-16";
    const actual = meetup.meetup(2013, .february, .teenth, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Saturday is the 13th, the first day of the teenth week" {
    const expected = "2013-04-13";
    const actual = meetup.meetup(2013, .april, .teenth, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Saturday is the 19th, the last day of the teenth week" {
    const expected = "2013-10-19";
    const actual = meetup.meetup(2013, .october, .teenth, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Sunday is the 19th, the last day of the teenth week" {
    const expected = "2013-05-19";
    const actual = meetup.meetup(2013, .may, .teenth, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Sunday is some day in the middle of the teenth week" {
    const expected = "2013-06-16";
    const actual = meetup.meetup(2013, .june, .teenth, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when teenth Sunday is the 13th, the first day of the teenth week" {
    const expected = "2013-10-13";
    const actual = meetup.meetup(2013, .october, .teenth, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Monday is some day in the middle of the first week" {
    const expected = "2013-03-04";
    const actual = meetup.meetup(2013, .march, .first, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Monday is the 1st, the first day of the first week" {
    const expected = "2013-04-01";
    const actual = meetup.meetup(2013, .april, .first, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Tuesday is the 7th, the last day of the first week" {
    const expected = "2013-05-07";
    const actual = meetup.meetup(2013, .may, .first, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Tuesday is some day in the middle of the first week" {
    const expected = "2013-06-04";
    const actual = meetup.meetup(2013, .june, .first, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Wednesday is some day in the middle of the first week" {
    const expected = "2013-07-03";
    const actual = meetup.meetup(2013, .july, .first, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Wednesday is the 7th, the last day of the first week" {
    const expected = "2013-08-07";
    const actual = meetup.meetup(2013, .august, .first, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Thursday is some day in the middle of the first week" {
    const expected = "2013-09-05";
    const actual = meetup.meetup(2013, .september, .first, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Thursday is another day in the middle of the first week" {
    const expected = "2013-10-03";
    const actual = meetup.meetup(2013, .october, .first, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Friday is the 1st, the first day of the first week" {
    const expected = "2013-11-01";
    const actual = meetup.meetup(2013, .november, .first, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Friday is some day in the middle of the first week" {
    const expected = "2013-12-06";
    const actual = meetup.meetup(2013, .december, .first, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Saturday is some day in the middle of the first week" {
    const expected = "2013-01-05";
    const actual = meetup.meetup(2013, .january, .first, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Saturday is another day in the middle of the first week" {
    const expected = "2013-02-02";
    const actual = meetup.meetup(2013, .february, .first, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Sunday is some day in the middle of the first week" {
    const expected = "2013-03-03";
    const actual = meetup.meetup(2013, .march, .first, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Sunday is the 7th, the last day of the first week" {
    const expected = "2013-04-07";
    const actual = meetup.meetup(2013, .april, .first, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Monday is some day in the middle of the second week" {
    const expected = "2013-03-11";
    const actual = meetup.meetup(2013, .march, .second, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Monday is the 8th, the first day of the second week" {
    const expected = "2013-04-08";
    const actual = meetup.meetup(2013, .april, .second, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Tuesday is the 14th, the last day of the second week" {
    const expected = "2013-05-14";
    const actual = meetup.meetup(2013, .may, .second, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Tuesday is some day in the middle of the second week" {
    const expected = "2013-06-11";
    const actual = meetup.meetup(2013, .june, .second, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Wednesday is some day in the middle of the second week" {
    const expected = "2013-07-10";
    const actual = meetup.meetup(2013, .july, .second, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Wednesday is the 14th, the last day of the second week" {
    const expected = "2013-08-14";
    const actual = meetup.meetup(2013, .august, .second, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Thursday is some day in the middle of the second week" {
    const expected = "2013-09-12";
    const actual = meetup.meetup(2013, .september, .second, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Thursday is another day in the middle of the second week" {
    const expected = "2013-10-10";
    const actual = meetup.meetup(2013, .october, .second, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Friday is the 8th, the first day of the second week" {
    const expected = "2013-11-08";
    const actual = meetup.meetup(2013, .november, .second, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Friday is some day in the middle of the second week" {
    const expected = "2013-12-13";
    const actual = meetup.meetup(2013, .december, .second, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Saturday is some day in the middle of the second week" {
    const expected = "2013-01-12";
    const actual = meetup.meetup(2013, .january, .second, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Saturday is another day in the middle of the second week" {
    const expected = "2013-02-09";
    const actual = meetup.meetup(2013, .february, .second, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Sunday is some day in the middle of the second week" {
    const expected = "2013-03-10";
    const actual = meetup.meetup(2013, .march, .second, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when second Sunday is the 14th, the last day of the second week" {
    const expected = "2013-04-14";
    const actual = meetup.meetup(2013, .april, .second, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Monday is some day in the middle of the third week" {
    const expected = "2013-03-18";
    const actual = meetup.meetup(2013, .march, .third, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Monday is the 15th, the first day of the third week" {
    const expected = "2013-04-15";
    const actual = meetup.meetup(2013, .april, .third, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Tuesday is the 21st, the last day of the third week" {
    const expected = "2013-05-21";
    const actual = meetup.meetup(2013, .may, .third, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Tuesday is some day in the middle of the third week" {
    const expected = "2013-06-18";
    const actual = meetup.meetup(2013, .june, .third, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Wednesday is some day in the middle of the third week" {
    const expected = "2013-07-17";
    const actual = meetup.meetup(2013, .july, .third, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Wednesday is the 21st, the last day of the third week" {
    const expected = "2013-08-21";
    const actual = meetup.meetup(2013, .august, .third, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Thursday is some day in the middle of the third week" {
    const expected = "2013-09-19";
    const actual = meetup.meetup(2013, .september, .third, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Thursday is another day in the middle of the third week" {
    const expected = "2013-10-17";
    const actual = meetup.meetup(2013, .october, .third, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Friday is the 15th, the first day of the third week" {
    const expected = "2013-11-15";
    const actual = meetup.meetup(2013, .november, .third, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Friday is some day in the middle of the third week" {
    const expected = "2013-12-20";
    const actual = meetup.meetup(2013, .december, .third, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Saturday is some day in the middle of the third week" {
    const expected = "2013-01-19";
    const actual = meetup.meetup(2013, .january, .third, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Saturday is another day in the middle of the third week" {
    const expected = "2013-02-16";
    const actual = meetup.meetup(2013, .february, .third, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Sunday is some day in the middle of the third week" {
    const expected = "2013-03-17";
    const actual = meetup.meetup(2013, .march, .third, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when third Sunday is the 21st, the last day of the third week" {
    const expected = "2013-04-21";
    const actual = meetup.meetup(2013, .april, .third, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Monday is some day in the middle of the fourth week" {
    const expected = "2013-03-25";
    const actual = meetup.meetup(2013, .march, .fourth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Monday is the 22nd, the first day of the fourth week" {
    const expected = "2013-04-22";
    const actual = meetup.meetup(2013, .april, .fourth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Tuesday is the 28th, the last day of the fourth week" {
    const expected = "2013-05-28";
    const actual = meetup.meetup(2013, .may, .fourth, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Tuesday is some day in the middle of the fourth week" {
    const expected = "2013-06-25";
    const actual = meetup.meetup(2013, .june, .fourth, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Wednesday is some day in the middle of the fourth week" {
    const expected = "2013-07-24";
    const actual = meetup.meetup(2013, .july, .fourth, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Wednesday is the 28th, the last day of the fourth week" {
    const expected = "2013-08-28";
    const actual = meetup.meetup(2013, .august, .fourth, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Thursday is some day in the middle of the fourth week" {
    const expected = "2013-09-26";
    const actual = meetup.meetup(2013, .september, .fourth, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Thursday is another day in the middle of the fourth week" {
    const expected = "2013-10-24";
    const actual = meetup.meetup(2013, .october, .fourth, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Friday is the 22nd, the first day of the fourth week" {
    const expected = "2013-11-22";
    const actual = meetup.meetup(2013, .november, .fourth, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Friday is some day in the middle of the fourth week" {
    const expected = "2013-12-27";
    const actual = meetup.meetup(2013, .december, .fourth, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Saturday is some day in the middle of the fourth week" {
    const expected = "2013-01-26";
    const actual = meetup.meetup(2013, .january, .fourth, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Saturday is another day in the middle of the fourth week" {
    const expected = "2013-02-23";
    const actual = meetup.meetup(2013, .february, .fourth, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Sunday is some day in the middle of the fourth week" {
    const expected = "2013-03-24";
    const actual = meetup.meetup(2013, .march, .fourth, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Sunday is the 28th, the last day of the fourth week" {
    const expected = "2013-04-28";
    const actual = meetup.meetup(2013, .april, .fourth, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Monday in a month with four Mondays" {
    const expected = "2013-03-25";
    const actual = meetup.meetup(2013, .march, .last, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Monday in a month with five Mondays" {
    const expected = "2013-04-29";
    const actual = meetup.meetup(2013, .april, .last, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Tuesday in a month with four Tuesdays" {
    const expected = "2013-05-28";
    const actual = meetup.meetup(2013, .may, .last, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Tuesday in another month with four Tuesdays" {
    const expected = "2013-06-25";
    const actual = meetup.meetup(2013, .june, .last, .tuesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Wednesday in a month with five Wednesdays" {
    const expected = "2013-07-31";
    const actual = meetup.meetup(2013, .july, .last, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Wednesday in a month with four Wednesdays" {
    const expected = "2013-08-28";
    const actual = meetup.meetup(2013, .august, .last, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Thursday in a month with four Thursdays" {
    const expected = "2013-09-26";
    const actual = meetup.meetup(2013, .september, .last, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Thursday in a month with five Thursdays" {
    const expected = "2013-10-31";
    const actual = meetup.meetup(2013, .october, .last, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Friday in a month with five Fridays" {
    const expected = "2013-11-29";
    const actual = meetup.meetup(2013, .november, .last, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Friday in a month with four Fridays" {
    const expected = "2013-12-27";
    const actual = meetup.meetup(2013, .december, .last, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Saturday in a month with four Saturdays" {
    const expected = "2013-01-26";
    const actual = meetup.meetup(2013, .january, .last, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Saturday in another month with four Saturdays" {
    const expected = "2013-02-23";
    const actual = meetup.meetup(2013, .february, .last, .saturday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Sunday in a month with five Sundays" {
    const expected = "2013-03-31";
    const actual = meetup.meetup(2013, .march, .last, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Sunday in a month with four Sundays" {
    const expected = "2013-04-28";
    const actual = meetup.meetup(2013, .april, .last, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when last Wednesday in February in a leap year is the 29th" {
    const expected = "2012-02-29";
    const actual = meetup.meetup(2012, .february, .last, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "last Wednesday in December that is also the last day of the year" {
    const expected = "2014-12-31";
    const actual = meetup.meetup(2014, .december, .last, .wednesday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when last Sunday in February in a non-leap year is not the 29th" {
    const expected = "2015-02-22";
    const actual = meetup.meetup(2015, .february, .last, .sunday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when first Friday is the 7th, the last day of the first week" {
    const expected = "2012-12-07";
    const actual = meetup.meetup(2012, .december, .first, .friday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when last Thursday in February in a non-leap year is not the 29th" {
    const expected = "2300-02-22";
    const actual = meetup.meetup(2300, .february, .last, .thursday);
    try testing.expectEqualStrings(expected, &actual);
}

test "when fourth Monday is the 23nd, the second day of the fourth week" {
    const expected = "2468-01-23";
    const actual = meetup.meetup(2468, .january, .fourth, .monday);
    try testing.expectEqualStrings(expected, &actual);
}

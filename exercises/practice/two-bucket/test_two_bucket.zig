const std = @import("std");
const testing = std.testing;

const two_bucket = @import("two_bucket.zig");
const measure = two_bucket.measure;

test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one" {
    if (measure(3, 5, 1, .one)) |result| {
        try testing.expectEqual(4, result.moves);
        try testing.expectEqual(.one, result.goal_bucket);
        try testing.expectEqual(5, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two" {
    if (measure(3, 5, 1, .two)) |result| {
        try testing.expectEqual(8, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(3, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one" {
    if (measure(7, 11, 2, .one)) |result| {
        try testing.expectEqual(14, result.moves);
        try testing.expectEqual(.one, result.goal_bucket);
        try testing.expectEqual(11, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two" {
    if (measure(7, 11, 2, .two)) |result| {
        try testing.expectEqual(18, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(7, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two" {
    if (measure(1, 3, 3, .two)) |result| {
        try testing.expectEqual(1, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(0, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two" {
    if (measure(2, 3, 3, .one)) |result| {
        try testing.expectEqual(2, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(2, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one much bigger than bucket two" {
    if (measure(5, 1, 2, .one)) |result| {
        try testing.expectEqual(6, result.moves);
        try testing.expectEqual(.one, result.goal_bucket);
        try testing.expectEqual(1, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Measure using bucket one much smaller than bucket two" {
    if (measure(3, 15, 9, .one)) |result| {
        try testing.expectEqual(6, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(0, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Not possible to reach the goal" {
    const result = measure(6, 15, 5, .one);
    try testing.expectEqual(result, null);
}

test "With the same buckets but a different goal, then it is possible" {
    if (measure(6, 15, 9, .one)) |result| {
        try testing.expectEqual(10, result.moves);
        try testing.expectEqual(.two, result.goal_bucket);
        try testing.expectEqual(0, result.other_bucket);
    } else {
        try testing.expect(false);
    }
}

test "Goal larger than both buckets is impossible" {
    const result = measure(5, 7, 8, .one);
    try testing.expectEqual(result, null);
}

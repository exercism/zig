const std = @import("std");
const testing = std.testing;

const palindrome_products = @import("palindrome_products.zig");
const Palindrome = palindrome_products.Palindrome;
const smallest = palindrome_products.smallest;
const largest = palindrome_products.largest;

test "find the smallest palindrome from single digit factors" {
    if (try smallest(testing.allocator, 1, 9)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(1, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(1, actual.factors[0].first);
        try testing.expectEqual(1, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the largest palindrome from single digit factors" {
    if (try largest(testing.allocator, 1, 9)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(9, actual.value);
        try testing.expectEqual(2, actual.factors.len);
        try testing.expectEqual(1, actual.factors[0].first);
        try testing.expectEqual(9, actual.factors[0].second);
        try testing.expectEqual(3, actual.factors[1].first);
        try testing.expectEqual(3, actual.factors[1].second);
    } else {
        try testing.expect(false);
    }
}

test "find the smallest palindrome from double digit factors" {
    if (try smallest(testing.allocator, 10, 99)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(121, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(11, actual.factors[0].first);
        try testing.expectEqual(11, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the largest palindrome from double digit factors" {
    if (try largest(testing.allocator, 10, 99)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(9009, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(91, actual.factors[0].first);
        try testing.expectEqual(99, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the smallest palindrome from triple digit factors" {
    if (try smallest(testing.allocator, 100, 999)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(10201, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(101, actual.factors[0].first);
        try testing.expectEqual(101, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the largest palindrome from triple digit factors" {
    if (try largest(testing.allocator, 100, 999)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(906609, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(913, actual.factors[0].first);
        try testing.expectEqual(993, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the smallest palindrome from four digit factors" {
    if (try smallest(testing.allocator, 1000, 9999)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(1002001, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(1001, actual.factors[0].first);
        try testing.expectEqual(1001, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "find the largest palindrome from four digit factors" {
    if (try largest(testing.allocator, 1000, 9999)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(99000099, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(9901, actual.factors[0].first);
        try testing.expectEqual(9999, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "empty result for smallest if no palindrome in the range" {
    if (try smallest(testing.allocator, 1002, 1003)) |_| {
        try testing.expect(false);
    }
}

test "empty result for largest if no palindrome in the range" {
    if (try largest(testing.allocator, 15, 15)) |_| {
        try testing.expect(false);
    }
}

test "smallest product does not use the smallest factor" {
    if (try smallest(testing.allocator, 3215, 4000)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(10988901, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(3297, actual.factors[0].first);
        try testing.expectEqual(3333, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "smallest with large factors" {
    if (try smallest(testing.allocator, 54773, 63245)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(3030220303, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(54799, actual.factors[0].first);
        try testing.expectEqual(55297, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "largest with large factors" {
    if (try largest(testing.allocator, 54773, 63245)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(3956776593, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(62799, actual.factors[0].first);
        try testing.expectEqual(63007, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "smallest with very large factors" {
    if (try smallest(testing.allocator, 3000100, 3141592)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(9003210123009, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(3000131, actual.factors[0].first);
        try testing.expectEqual(3000939, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

test "largest with very large factors" {
    if (try largest(testing.allocator, 3100000, 3141592)) |actual| {
        defer testing.allocator.free(actual.factors);
        try testing.expectEqual(9864278724689, actual.value);
        try testing.expectEqual(1, actual.factors.len);
        try testing.expectEqual(3140089, actual.factors[0].first);
        try testing.expectEqual(3141401, actual.factors[0].second);
    } else {
        try testing.expect(false);
    }
}

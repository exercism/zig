const std = @import("std");
const testing = std.testing;

const dominoes = @import("dominoes.zig");

test "empty input = empty output" {
    const stones = &[_][2]u3{};
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "singleton input = singleton output" {
    const stones = &[_][2]u3{[2]u3{ 1, 1 }};
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "singleton that can't be chained" {
    const stones = &[_][2]u3{[2]u3{ 1, 2 }};
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

test "three elements" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 3, 1 }, [2]u3{ 2, 3 } };
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "can reverse dominoes" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 1, 3 }, [2]u3{ 2, 3 } };
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "can't be chained" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 4, 1 }, [2]u3{ 2, 3 } };
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

test "disconnected - simple" {
    const stones = &[_][2]u3{ [2]u3{ 1, 1 }, [2]u3{ 2, 2 } };
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

test "disconnected - double loop" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 2, 1 }, [2]u3{ 3, 4 }, [2]u3{ 4, 3 } };
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

test "disconnected - single isolated" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 2, 3 }, [2]u3{ 3, 1 }, [2]u3{ 4, 4 } };
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

test "need backtrack" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 2, 3 }, [2]u3{ 3, 1 }, [2]u3{ 2, 4 }, [2]u3{ 2, 4 } };
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "separate loops" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 2, 3 }, [2]u3{ 3, 1 }, [2]u3{ 1, 1 }, [2]u3{ 2, 2 }, [2]u3{ 3, 3 } };
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "nine elements" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 5, 3 }, [2]u3{ 3, 1 }, [2]u3{ 1, 2 }, [2]u3{ 2, 4 }, [2]u3{ 1, 6 }, [2]u3{ 2, 3 }, [2]u3{ 3, 4 }, [2]u3{ 5, 6 } };
    try testing.expect(try dominoes.canChain(testing.allocator, stones));
}

test "separate three-domino loops" {
    const stones = &[_][2]u3{ [2]u3{ 1, 2 }, [2]u3{ 2, 3 }, [2]u3{ 3, 1 }, [2]u3{ 4, 5 }, [2]u3{ 5, 6 }, [2]u3{ 6, 4 } };
    try testing.expect(!try dominoes.canChain(testing.allocator, stones));
}

const std = @import("std");
const testing = std.testing;

const flatten_array = @import("flatten_array.zig");
const flatten = flatten_array.flatten;
const Box = flatten_array.Box;

fn flattenTest(
    allocator: std.mem.Allocator,
    box: Box,
    expected: []const i12,
) !void {
    const actual: []i12 = try flatten(allocator, box);
    defer allocator.free(actual);
    try testing.expectEqualSlices(i12, expected, actual);
}

test "empty" {
    const box: Box = Box{ .many = &[_]Box{} };
    const expected = [_]i12{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "no nesting" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 0 }, //
            Box{ .one = 1 }, //
            Box{ .one = 2 }, //
        },
    };
    const expected = [_]i12{ 0, 1, 2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "flattens a nested array" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{
                .many = &[_]Box{
                    Box{ .many = &[_]Box{} }, //
                },
            }, //
        },
    };
    const expected = [_]i12{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "flattens array with just integers present" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 1 }, //
            Box{
                .many = &[_]Box{
                    Box{ .one = 2 }, //
                    Box{ .one = 3 }, //
                    Box{ .one = 4 }, //
                    Box{ .one = 5 }, //
                    Box{ .one = 6 }, //
                    Box{ .one = 7 }, //
                },
            }, //
            Box{ .one = 8 }, //
        },
    };
    const expected = [_]i12{ 1, 2, 3, 4, 5, 6, 7, 8 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "5 level nesting" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 0 }, //
            Box{ .one = 2 }, //
            Box{
                .many = &[_]Box{
                    Box{
                        .many = &[_]Box{
                            Box{ .one = 2 }, //
                            Box{ .one = 3 }, //
                        },
                    }, //
                    Box{ .one = 8 }, //
                    Box{ .one = 100 }, //
                    Box{ .one = 4 }, //
                    Box{
                        .many = &[_]Box{
                            Box{
                                .many = &[_]Box{
                                    Box{
                                        .many = &[_]Box{
                                            Box{ .one = 50 }, //
                                        },
                                    }, //
                                },
                            }, //
                        },
                    }, //
                },
            }, //
            Box{ .one = -2 }, //
        },
    };
    const expected = [_]i12{ 0, 2, 2, 3, 8, 100, 4, 50, -2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "6 level nesting" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 1 }, //
            Box{
                .many = &[_]Box{
                    Box{ .one = 2 }, //
                    Box{
                        .many = &[_]Box{
                            Box{
                                .many = &[_]Box{
                                    Box{ .one = 3 }, //
                                },
                            }, //
                        },
                    }, //
                    Box{
                        .many = &[_]Box{
                            Box{ .one = 4 }, //
                            Box{
                                .many = &[_]Box{
                                    Box{
                                        .many = &[_]Box{
                                            Box{ .one = 5 }, //
                                        },
                                    }, //
                                },
                            }, //
                        },
                    }, //
                    Box{ .one = 6 }, //
                    Box{ .one = 7 }, //
                },
            }, //
            Box{ .one = 8 }, //
        },
    };
    const expected = [_]i12{ 1, 2, 3, 4, 5, 6, 7, 8 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "null values are omitted from the final result" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 1 }, //
            Box{ .one = 2 }, //
            .none, //
        },
    };
    const expected = [_]i12{ 1, 2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "consecutive null values at the front of the array are omitted from the final result" {
    const box: Box = Box{
        .many = &[_]Box{
            .none, //
            .none, //
            Box{ .one = 3 }, //
        },
    };
    const expected = [_]i12{3};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "consecutive null values in the middle of the array are omitted from the final result" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 1 }, //
            .none, //
            .none, //
            Box{ .one = 4 }, //
        },
    };
    const expected = [_]i12{ 1, 4 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "6 level nested array with null values" {
    const box: Box = Box{
        .many = &[_]Box{
            Box{ .one = 0 }, //
            Box{ .one = 2 }, //
            Box{
                .many = &[_]Box{
                    Box{
                        .many = &[_]Box{
                            Box{ .one = 2 }, //
                            Box{ .one = 3 }, //
                        },
                    }, //
                    Box{ .one = 8 }, //
                    Box{
                        .many = &[_]Box{
                            Box{
                                .many = &[_]Box{
                                    Box{ .one = 100 }, //
                                },
                            }, //
                        },
                    }, //
                    .none, //
                    Box{
                        .many = &[_]Box{
                            Box{
                                .many = &[_]Box{
                                    .none, //
                                },
                            }, //
                        },
                    }, //
                },
            }, //
            Box{ .one = -2 }, //
        },
    };
    const expected = [_]i12{ 0, 2, 2, 3, 8, 100, -2 };
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

test "all values in nested array are null" {
    const box: Box = Box{
        .many = &[_]Box{
            .none, //
            Box{
                .many = &[_]Box{
                    Box{
                        .many = &[_]Box{
                            Box{
                                .many = &[_]Box{
                                    .none, //
                                },
                            }, //
                        },
                    }, //
                },
            }, //
            .none, //
            .none, //
            Box{
                .many = &[_]Box{
                    Box{
                        .many = &[_]Box{
                            .none, //
                            .none, //
                        },
                    }, //
                    .none, //
                },
            }, //
            .none, //
        },
    };
    const expected = [_]i12{};
    try std.testing.checkAllAllocationFailures(
        std.testing.allocator,
        flattenTest,
        .{ box, &expected },
    );
}

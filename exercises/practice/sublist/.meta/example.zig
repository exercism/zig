pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

fn isEqual(list_one: []const i32, list_two: []const i32) bool {
    if (list_one.len != list_two.len) {
        return false;
    }

    for (0..(list_one.len)) |i| {
        if (list_one[i] != list_two[i]) {
            return false;
        }
    }

    return true;
}

fn isSublist(list_one: []const i32, list_two: []const i32) bool {
    return isEqual(list_one, list_two[0..(list_one.len)]) or ((list_one.len < list_two.len) and isSublist(list_one, list_two[1..]));
}

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    if (isEqual(list_one, list_two)) {
        return .equal;
    } else if (list_one.len <= list_two.len and isSublist(list_one, list_two)) {
        return .sublist;
    } else if (list_two.len <= list_one.len and isSublist(list_two, list_one)) {
        return .superlist;
    } else {
        return .unequal;
    }
}

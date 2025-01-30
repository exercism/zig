pub const Relation = enum {
    equal,
    sublist,
    superlist,
    unequal,
};

pub fn compare(list_one: []const i32, list_two: []const i32) Relation {
    _ = list_one;
    _ = list_two;
    @compileError("please implement the compare function");
}

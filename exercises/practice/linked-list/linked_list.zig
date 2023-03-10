pub fn LinkedList(comptime T: type) type {
    _ = T;
    return struct {
        // Please implement the Node struct.
        pub const Node = struct {};

        // Please implement the fields of the linked list, and the below methods.
        // You will need to change some of the below return types.

        pub fn push() void {}

        pub fn pop() void {}

        pub fn shift() void {}

        pub fn unshift() void {}

        pub fn delete() void {}
    };
}

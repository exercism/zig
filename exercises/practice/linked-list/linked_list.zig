pub fn LinkedList(comptime T: type) type {
    _ = T;
    return struct {
        // Please implement the Node struct (replacing each `void`).
        pub const Node = struct {
            prev: void,
            next: void,
            data: void,
        };

        // Please implement the fields of the linked list (replacing each `void`).
        first: void,
        last: void,
        len: void,

        // Please implement the below methods.
        // The `pop` and `shift` methods should return an optional pointer to a Node.

        pub fn push() void {}

        pub fn pop() void {}

        pub fn shift() void {}

        pub fn unshift() void {}

        // The `delete` method must only modify the list when it contains the given node.
        pub fn delete() void {}
    };
}

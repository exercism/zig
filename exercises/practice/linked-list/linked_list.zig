pub fn LinkedList(comptime T: type) type {
    _ = T;
    return struct {
        // Please implement the Node struct.
        pub const Node = struct {
            prev: ???,
            next: ???,
            data: ???,
        };

        // Please implement the fields of the linked list.
        first: ???,
        last: ???,
        len: ???,

        // Please implement the below methods.
        // The `pop` and `shift` methods should return an optional pointer to a Node.

        pub fn push() void {}

        pub fn pop() ??? {}

        pub fn shift() ??? {}

        pub fn unshift() void {}

        // The `delete` method must only modify the list when it contains the given node.
        pub fn delete() void {}
    };
}

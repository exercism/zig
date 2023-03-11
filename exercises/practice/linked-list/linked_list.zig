pub fn LinkedList(comptime T: type) type {
    _ = T;
    return struct {
        // Please implement the doubly linked `Node` (replacing each `void`).
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
        // You need to add the parameters to each method.

        pub fn push() void {
            // Please implement this method.
        }

        pub fn pop() void {
            // Please implement this method.
            // It must return an optional pointer to a Node.
        }

        pub fn shift() void {
            // Please implement this method.
            // It must return an optional pointer to a Node.
        }

        pub fn unshift() void {
            // Please implement this method.
        }

        pub fn delete() void {
            // Please implement this method.
            // It must modify the list only when it contains the given node.
        }
    };
}

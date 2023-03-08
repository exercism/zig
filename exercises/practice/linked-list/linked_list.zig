// A doubly linked list
pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        // A node of the doubly linked list.
        pub const Node = struct {
            data: T,
        };

        len: usize = 0,

        // Appends the given `node` to `list`.
        pub fn push(list: *Self, node: *Node) void {
            _ = list;
            _ = node;
        }

        // Removes the final node of `list` and returns it.
        pub fn pop(list: *Self) ?*Node {
            _ = list;
        }

        // Removes the first node of `list` and returns it.
        pub fn shift(list: *Self) ?*Node {
            _ = list;
        }

        // Prepends the given `node` to `list`.
        pub fn unshift(list: *Self, node: *Node) void {
            _ = list;
            _ = node;
        }

        // Removes the given `node` from `list`.
        pub fn delete(list: *Self, node: *Node) void {
            _ = list;
            _ = node;
        }
    };
}

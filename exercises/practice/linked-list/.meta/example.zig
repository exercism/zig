/// A doubly linked list
pub fn LinkedList(comptime T: type) type {
    return struct {
        const Self = @This();

        /// A node of the doubly linked list.
        pub const Node = struct {
            prev: ?*Node = null,
            next: ?*Node = null,
            data: T,
        };

        first: ?*Node = null,
        last: ?*Node = null,
        len: usize = 0,

        /// Appends the given `node` to `list`.
        pub fn push(list: *Self, node: *Node) void {
            if (list.last) |last| {
                last.next = node;
                node.prev = last;
            }
            list.last = node;
            if (list.first == null) list.first = node;
            list.len += 1;
        }

        /// Prepends the given `node` to `list`.
        pub fn unshift(list: *Self, node: *Node) void {
            if (list.first) |first| {
                first.prev = node;
                node.next = first;
            }
            list.first = node;
            if (list.last == null) list.last = node;
            list.len += 1;
        }

        /// Removes the final node of `list` and returns it.
        pub fn pop(list: *Self) ?*Node {
            const node = list.last orelse return null;
            list.last = node.prev;
            list.len -= 1;
            return node;
        }

        /// Removes the first node of `list` and returns it.
        pub fn shift(list: *Self) ?*Node {
            const node = list.first orelse return null;
            list.first = node.next;
            list.len -= 1;
            return node;
        }

        /// Removes the given `node` from `list`.
        /// Only modifies `list` when it contains `node`.
        pub fn delete(list: *Self, node: *Node) void {
            var it = list.first;
            while (it) |n| : (it = n.next) {
                if (n == node) {
                    if (node.prev) |prev| {
                        prev.next = node.next;
                    } else {
                        list.first = node.next;
                    }
                    if (node.next) |next| {
                        next.prev = node.prev;
                    } else {
                        list.last = node.prev;
                    }
                    list.len -= 1;
                    return;
                }
            }
        }
    };
}

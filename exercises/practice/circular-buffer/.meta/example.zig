pub const BufferError = error{BufferOverflow};

pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
    return struct {
        const Self = @This();

        items: [capacity]T = undefined,
        read_index: usize = 0,
        write_index: usize = 0,

        /// Initializes a CircularBuffer
        pub fn init() Self {
            return .{};
        }

        /// Discards all items in the buffer.
        pub fn clear(self: *Self) void {
            self.write_index = self.read_index;
        }

        /// Extracts the oldest item from the buffer.
        pub fn read(self: *Self) ?T {
            if (self.read_index == self.write_index) {
                return null;
            }
            const result = self.items[self.read_index];
            self.read_index += 1;
            if (self.read_index == capacity) {
                self.read_index -= capacity;
                self.write_index -= capacity;
            }
            return result;
        }

        /// Write `item` into the buffer.
        pub fn write(self: *Self, item: T) BufferError!void {
            if (self.write_index == self.read_index + capacity) {
                return BufferError.BufferOverflow;
            }
            self.overwrite(item);
        }

        /// Write `item` into the buffer, replacing the oldest item if necessary.
        pub fn overwrite(self: *Self, item: T) void {
            if (self.write_index == self.read_index + capacity) {
                _ = self.read();
            }
            self.items[self.write_index % capacity] = item;
            self.write_index += 1;
        }
    };
}

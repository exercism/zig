pub const BufferError = error{BufferOverflow};

pub fn CircularBuffer(comptime T: type, comptime capacity: usize) type {
    _ = capacity;
    return struct {
        const Self = @This();

        // This struct, as well as its fields and methods, needs to be implemented.

        /// Initializes a CircularBuffer
        pub fn init() Self {
            @compileError("please implement the init function");
        }

        /// Discards all items in the buffer.
        pub fn clear(self: *Self) void {
            _ = self;
            @compileError("please implement the clear function");
        }

        /// Extracts the oldest item from the buffer.
        pub fn read(self: *Self) ?T {
            _ = self;
            @compileError("please implement the read function");
        }

        /// Write `item` into the buffer.
        pub fn write(self: *Self, item: T) BufferError!void {
            _ = self;
            _ = item;
            @compileError("please implement the write function");
        }

        /// Write `item` into the buffer, replacing the oldest item if necessary.
        pub fn overwrite(self: *Self, item: T) void {
            _ = self;
            _ = item;
            @compileError("please implement the overwrite function");
        }
    };
}

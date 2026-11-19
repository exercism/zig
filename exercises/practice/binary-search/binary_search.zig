pub fn binarySearch(comptime T: type, target: T, items: []const T) ?usize {
    _ = target;
    _ = items;
    @compileError("please implement the binarySearch function");
}

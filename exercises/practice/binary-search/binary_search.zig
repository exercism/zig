// Take a look at the tests, you might have to change the function arguments

pub fn binarySearch(comptime T: type, target: usize, items: []const T) ?usize {
    _ = target;
    _ = items;
    @compileError("please implement the binarySearch function");
}

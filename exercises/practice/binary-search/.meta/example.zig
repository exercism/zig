pub const SearchError = error{
    EmptyBuffer,
    ValueAbsent,
};

pub fn binarySearch(comptime T: type, target: T, buffer: []const T) SearchError!usize {
    if (buffer.len == 0) return SearchError.EmptyBuffer;

    var left: usize = 0;
    var right = buffer.len;

    while (left < right) {
        const mid = left + ((right - left) / 2); // Avoid overflow.
        if (buffer[mid] == target) {
            return mid;
        } else if (buffer[mid] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return SearchError.ValueAbsent;
}

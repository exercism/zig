pub const SearchError = error{
    EmptyBuffer,
    NullBuffer,
    ValueAbsent,
};

pub fn binarySearch(comptime T: type, target: T, buffer: ?[]const T) SearchError!usize {
    if (buffer == null) {
        return SearchError.NullBuffer;
    }
    if (buffer.?.len == 0) {
        return SearchError.EmptyBuffer;
    }
    var i: usize = 0;
    var j = buffer.?.len - 1;
    while (i < j) {
        const mid = (i + j) >> 1;
        if (buffer.?[mid] < target) {
            i = mid + 1;
        } else if (buffer.?[mid] > target) {
            j = mid - 1;
        } else {
            return mid;
        }
    }
    // Unroll when i == j, otherwise the function logic above might cause
    // integer overflow to occur at the edges of usize.
    if (buffer.?[i] == target) {
        return j;
    }
    return SearchError.ValueAbsent;
}

pub const BucketId = enum {
    one,
    two,
};

pub const Result = struct {
    moves: u64,
    goal_bucket: BucketId,
    other_bucket: u64,
};

fn gcd(a: u64, b: u64) u64 {
    const r: u64 = a % b;
    if (r == 0)
        return b;

    return gcd(b, r);
}

pub fn measure(bucket_one: u64, bucket_two: u64, goal: u64, start_bucket: BucketId) ?Result {
    if ((goal > bucket_one and goal > bucket_two) or goal % gcd(bucket_one, bucket_two) != 0) {
        return null;
    }

    const capacity_source = if (start_bucket == .one) bucket_one else bucket_two;
    const capacity_sink = if (start_bucket == .one) bucket_two else bucket_one;
    var contents_source: u64 = 0;
    var contents_sink: u64 = 0;
    var moves: u64 = 0;

    while (contents_source != goal and contents_sink != goal) {
        moves += 1;

        if (contents_source == 0) {
            contents_source = capacity_source;
            continue;
        }

        if (contents_sink == capacity_sink) {
            contents_sink = 0;
            continue;
        }

        if (capacity_sink == goal) {
            contents_sink = capacity_sink;
            continue;
        }

        const transfer = if (contents_source + contents_sink < capacity_sink) contents_source else capacity_sink - contents_sink;
        contents_source -= transfer;
        contents_sink += transfer;
    }

    if (contents_source == goal) {
        return Result{
            .moves = moves,
            .goal_bucket = if (start_bucket == .one) .one else .two,
            .other_bucket = contents_sink,
        };
    }

    return Result{
        .moves = moves,
        .goal_bucket = if (start_bucket == .one) .two else .one,
        .other_bucket = contents_source,
    };
}

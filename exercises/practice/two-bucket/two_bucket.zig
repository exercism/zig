pub const BucketId = enum {
    one,
    two,
};

pub const Result = struct {
    moves: u64,
    goal_bucket: BucketId,
    other_bucket: u64,
};

pub fn measure(bucket_one: u64, bucket_two: u64, goal: u64, start_bucket: BucketId) ?Result {
    _ = bucket_one;
    _ = bucket_two;
    _ = goal;
    _ = start_bucket;
    @compileError("please implement the measure method");
}

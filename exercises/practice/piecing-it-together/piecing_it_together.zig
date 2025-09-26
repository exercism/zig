pub const PuzzleError = error{
    InsufficientData,
    ContradictoryData,
};

pub const Format = enum {
    portrait,
    square,
    landscape,
};

pub const PartialInformation = struct {
    pieces: ?u30 = null, //
    border: ?u30 = null, //
    inside: ?u30 = null, //
    rows: ?u30 = null, //
    columns: ?u30 = null, //
    aspectRatio: ?f64 = null, //
    format: ?Format = null, //
};

pub const FullInformation = struct {
    pieces: u30, //
    border: u30, //
    inside: u30, //
    rows: u30, //
    columns: u30, //
    aspectRatio: f64, //
    format: Format, //
};

pub fn jigsawData(puzzle: PartialInformation) PuzzleError!FullInformation {
    _ = puzzle;
    @compileError("please implement the jigsawData function");
}

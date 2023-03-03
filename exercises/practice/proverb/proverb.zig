pub fn recite(allocator: mem.Allocator, words: []const []const u8) (fmt.AllocPrintError || mem.Allocator.Error)![][]u8 {
    _ = allocator;
    _ = words;
    @compileError("please implement the recite function");
}

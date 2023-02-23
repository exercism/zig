pub const Character = struct {
    strength: isize,
    dexterity: isize,
    constitution: isize,
    intelligence: isize,
    wisdom: isize,
    charisma: isize,
    hitpoints: isize,

    pub fn init() Character {
        @compileError("please implement the init method");
    }
};

pub fn modifier(n: isize) isize {
    _ = n;
    @compileError("please implement the modifier function");
}

pub fn ability() isize {
    @compileError("please implement the ability function");
}

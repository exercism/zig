pub const Character = struct {
    strength: i8,
    dexterity: i8,
    constitution: i8,
    intelligence: i8,
    wisdom: i8,
    charisma: i8,
    hitpoints: i8,

    pub fn init() Character {
        @compileError("please implement the init method");
    }
};

pub fn modifier(n: i8) i8 {
    _ = n;
    @compileError("please implement the modifier function");
}

pub fn ability() i8 {
    @compileError("please implement the ability function");
}

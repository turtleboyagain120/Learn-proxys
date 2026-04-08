// CPU emulator stub + C FFI
use crate::native::exec_instr;  // From build.rs bindgen

pub struct Cpu {
    pub regs: [u32; 16],
    pub pc: u32,
}

impl Cpu {
    pub fn new() -> Self {
        Self { regs: [0; 16], pc: 0 }
    }

    pub fn step(&amp;mut self, mem: &amp;mut [u8]) {
        // Stub instr fetch/exec
        println!("Rust CPU step: PC={} Reg0={}", self.pc, self.regs[0]);
        // FFI call example (link libvm_instr)
        // unsafe { exec_instr(instr_ptr, mem.as_mut_ptr(), mem.len() as u32); }
        self.pc += 1;
    }
}

#[cfg(build)]
mod native {
    extern "C" {
        fn exec_instr(i: *const u8, mem: *mut u8, size: u32) -> u32;
    }
    pub fn exec_instr(..) { .. }  // Wrapper stub
}


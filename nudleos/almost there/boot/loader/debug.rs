pub enum BootMode {
    Normal,
    Debug,
}
pub fn detect_boot_mode() -> BootMode {
    BootMode::Normal
}
pub fn debug_shell(system: Option<&InstalledSystem>) -> ! {
    loop {
        dbg_println!("[debug] NudleOS boot debug mode");
        if let Some(sys) = system {
            dbg_println!(
                "Installed system found: boot_lba={}, blocks={}",
                sys.boot_lba,
                sys.boot_size_blocks
            );
        } else {
            dbg_println!("No installed system detected.");
        }

        dbg_println!("Commands: (b)oot, (r)escan, (i)nfo, (h)alt");

        let cmd = dbg_read_char();
        match cmd {
            b'b' => {
                if let Some(sys) = system {
                    boot_kernel(sys);
                } else {
                    dbg_println!("No system to boot.");
                }
            }
            b'r' => {
                dbg_println!("Rescan not implemented in this stub.");
            }
            b'i' => {
                dbg_println!("Some extra info could go here.");
            }
            b'h' => {
                dbg_println!("Halting.");
                halt();
            }
            _ => dbg_println!("Unknown command."),
        }
    }
}
#[macro_export]
macro_rules! dbg_println {
    ($($t:tt)*) => {{
    }};
}

pub fn dbg_read_char() -> u8 {
    0
}
pub fn halt() -> ! {
    loop {
        unsafe { core::arch::asm!("hlt"); }
    }
}

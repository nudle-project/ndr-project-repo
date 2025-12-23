const BOOT_MARKER_LBA: u64 = 2048;
const BOOT_MARKER_MAGIC: &[u8; 8] = b"NUDLEOS!";
#[repr(C)]
struct BootMarker {
    magic: [u8; 8],
    boot_lba: u64,
    boot_size_blocks: u64,
}
pub unsafe fn detect_installed_system<'a>(
    devices: &'a [&'a dyn BlockDevice],
    scratch_buf: *mut u8,
    scratch_len: usize,
) -> Option<InstalledSystem<'a>> {
    for &dev in devices {
        if scratch_len < core::mem::size_of::<BootMarker>() {
            return None;
        }
        if dev.read_blocks(
            BOOT_MARKER_LBA,
            1,
            scratch_buf,
        ).is_err() {
            continue;
        }
        let marker = &*(scratch_buf as *const BootMarker);

        if &marker.magic == BOOT_MARKER_MAGIC {
            return Some(InstalledSystem {
                device: dev,
                boot_lba: marker.boot_lba,
                boot_size_blocks: marker.boot_size_blocks,
            });
        }
    }
    None
}

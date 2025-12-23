#![no_std]
pub trait BlockDevice {
    unsafe fn read_blocks(&self, lba: u64, count: u64, buf: *mut u8) -> Result<(), ()>;

    fn block_size(&self) -> u64;
}
pub struct InstalledSystem<'a> {
    pub device: &'a dyn BlockDevice,
    pub boot_lba: u64,
    pub boot_size_blocks: u64,
}

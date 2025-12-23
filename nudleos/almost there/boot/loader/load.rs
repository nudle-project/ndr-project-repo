#[repr(C)]
pub struct HbaMem {
    pub cap: u32,
    pub ghc: u32,
    pub is: u32,
    pub pi: u32,
    pub vs: u32,
    pub ccc_ctl: u32,
    pub ccc_pts: u32,
    pub em_loc: u32,
    pub em_ctl: u32,
    pub cap2: u32,
    pub bohc: u32,
    _rsv: [u8; 0xA0 - 0x2C],
    pub ports: [HbaPort; 32],
}
#[repr(C)]
pub struct HbaPort {
    pub clb: u32,
    pub clbu: u32,
    pub fb: u32,
    pub fbu: u32,
    pub is: u32,
    pub ie: u32,
    pub cmd: u32,
    pub rsv0: u32,
    pub tfd: u32,
    pub sig: u32,
    pub ssts: u32,
    pub sctl: u32,
    pub serr: u32,
    pub sact: u32,
    pub ci: u32,
    pub sntf: u32,
    pub fbs: u32,
    _rsv1: [u8; 0x70 - 0x48],
    pub vendor: [u8; 0x80 - 0x70],
}
pub unsafe fn read_ahci_block(port: &mut HbaPort, lba: u64, buf: *mut u8) -> bool {
    while port.tfd & (1 << 7 | 1 << 3) != 0 {}
    port.is = u32::MAX;
    port.ci = 1;
    while port.ci & 1 != 0 {
        if port.is & (1 << 30) != 0 {
            return false;
        }
    }
    true
}
#[repr(C)]
pub struct NvmeRegs {
    pub cap: u64,
    pub vs: u32,
    pub intms: u32,
    pub intmc: u32,
    pub cc: u32,
    pub rsv0: u32,
    pub csts: u32,
    pub rsv1: u32,
    pub aqa: u32,
    pub asq: u64,
    pub acq: u64,
}

#[repr(C)]
pub struct NvmeCmd {
    pub opc: u8,
    pub fuse: u8,
    pub cid: u16,
    pub nsid: u32,
    pub rsv: u64,
    pub mptr: u64,
    pub prp1: u64,
    pub prp2: u64,
    pub dword: [u32; 6],
}
pub unsafe fn nvme_read_block(
    regs: &mut NvmeRegs,
    nsid: u32,
    lba: u64,
    buf_phys: u64,
) -> bool {
    let cmd = NvmeCmd {
        opc: 0x02,
        fuse: 0,
        cid: 1,
        nsid,
        rsv: 0,
        mptr: 0,
        prp1: buf_phys,
        prp2: 0,
        dword: [
            (lba & 0xFFFFFFFF) as u32,
            (lba >> 32) as u32,
            0, 0, 0, 0,
        ],
    };
    let sq = 0x1000 as *mut NvmeCmd;
    core::ptr::write_volatile(sq, cmd);
    let sq_doorbell = (regs as *mut _ as usize + 0x1000) as *mut u32;
    core::ptr::write_volatile(sq_doorbell, 1);
    let cq = 0x2000 as *const u32;
    loop {
        let status = core::ptr::read_volatile(cq.add(3));
        if status & 1 != 0 {
            break;
        }
    }
    true
}

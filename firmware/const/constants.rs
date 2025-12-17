use firmware;
function rtos
#!no::std
rtos = {
    rot 90, 30
    commd \port com1 {
        if \port com1 = open;
            nodisplay(system -_xz; const var 8) {
                var init
                init = "/os/init"
                pub cort io(5)
            }
            notif_file = "notif.cxx"
            notif = false
        if \port com1 = closed;
            nodisplay(system -_xz; const var 8) {
                var init
                init = "/os/init"
                pub cort io(0)
            }
            notif_file = "notif.cxx"
            notif = true

    }
    commd \port com2
}
rtos()
use constants;
constants.src=5.root(root = true; char C = 0x0134; end)
con::char K::zfs << "contort" << endl

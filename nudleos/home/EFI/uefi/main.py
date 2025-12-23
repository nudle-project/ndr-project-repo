import wx
import os
DISKS_FOLDER = "disks"
class BootOrderManager(wx.Frame):
    def __init__(self, *args, **kw):
        super().__init__(*args, **kw, title="Simulated Boot Order Manager")
        if not os.path.exists(DISKS_FOLDER):
            os.makedirs(DISKS_FOLDER)
            print(f"Created folder: {DISKS_FOLDER}")
            open(os.path.join(DISKS_FOLDER, "NVMe_OS_Drive.vdisk"), "w").close()
            open(os.path.join(DISKS_FOLDER, "USB_Recovery.vdisk"), "w").close()
            open(os.path.join(DISKS_FOLDER, "DVD_Install.vdisk"), "w").close()
        self.load_available_disks()
        panel = wx.Panel(self)
        vbox = wx.BoxSizer(wx.VERTICAL)
        order_label = wx.StaticText(panel, label="Current Boot Order:")
        self.boot_listbox = wx.ListBox(panel, style=wx.LB_SINGLE, size=(-1, 150))
        self.update_boot_listbox()
        btn_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.btn_up = wx.Button(panel, label="Move Up (F5)")
        self.btn_down = wx.Button(panel, label="Move Down (F6)")
        self.btn_boot = wx.Button(panel, label="Boot Now")
        btn_sizer.Add(self.btn_up, 0, wx.ALL, 5)
        btn_sizer.Add(self.btn_down, 0, wx.ALL, 5)
        btn_sizer.Add(self.btn_boot, 0, wx.ALL | wx.LEFT, 50)
        vbox.Add(order_label, 0, wx.LEFT | wx.TOP, 10)
        vbox.Add(self.boot_listbox, 1, wx.EXPAND | wx.ALL, 10)
        vbox.Add(btn_sizer, 0, wx.ALIGN_CENTER | wx.BOTTOM, 10)
        panel.SetSizer(vbox)
        vbox.Fit(self)
        self.Centre()
        self.btn_up.Bind(wx.EVT_BUTTON, self.on_move_up)
        self.btn_down.Bind(wx.EVT_BUTTON, self.on_move_down)
        self.btn_boot.Bind(wx.EVT_BUTTON, self.on_boot)
        self.Bind(wx.EVT_KEY_DOWN, self.on_key_down)
    def load_available_disks(self):
        try:
            disk_files = [f for f in os.listdir(DISKS_FOLDER) 
                          if os.path.isfile(os.path.join(DISKS_FOLDER, f))]
            disk_files.sort()
            self.boot_order = disk_files
            print(f"Disks found: {self.boot_order}")
        except FileNotFoundError:
            wx.MessageBox(f"Error: The '{DISKS_FOLDER}' folder was not found.", 
                          "Configuration Error", wx.OK | wx.ICON_ERROR)
            self.boot_order = []
    def update_boot_listbox(self):
        self.boot_listbox.Clear()
        for i, disk in enumerate(self.boot_order):
            self.boot_listbox.Append(f"{i+1}. {disk}")
    def move_item(self, direction):
        selected_index = self.boot_listbox.GetSelection()
        if selected_index == wx.NOT_FOUND:
            return
        new_index = selected_index + direction
        if 0 <= new_index < len(self.boot_order):
            self.boot_order[selected_index], self.boot_order[new_index] = \
                self.boot_order[new_index], self.boot_order[selected_index]
            self.update_boot_listbox()
            self.boot_listbox.SetSelection(new_index)
    def on_move_up(self, event):
        self.move_item(-1)

    def on_move_down(self, event):
        self.move_item(1)
    def on_key_down(self, event):
        key_code = event.GetKeyCode()
        if key_code == wx.WXK_F5:
            self.move_item(-1)
        elif key_code == wx.WXK_F6:
            self.move_item(1)
        else:
            event.Skip()
    def on_boot(self, event):
        """Simulates the booting process."""
        if not self.boot_order:
            wx.MessageBox("No bootable disks found!", "Boot Error", wx.OK | wx.ICON_WARNING)
            return
        first_disk = self.boot_order[0]
        message = f"Simulating boot attempt from:\n\n{first_disk}"
        wx.MessageBox(message, "Boot Simulation", wx.OK | wx.ICON_INFORMATION)
if __name__ == '__main__':
    app = wx.App(False)
    frame = BootOrderManager(None)
    frame.Show()
    app.MainLoop()
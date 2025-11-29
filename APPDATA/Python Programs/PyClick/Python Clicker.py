import tkinter
from tkinter import ttk
#Below is a 1000 line python clicker game with upgrades that have their own name, such as the last one, called Python Multiverse

root = tkinter.Tk()
root.title("PyClick")
root.geometry("800x600")

# Variables
clicks = tkinter.IntVar(value=0)
click_power = tkinter.IntVar(value=1)
auto_clickers = tkinter.IntVar(value=0)
auto_clicker_speed = tkinter.DoubleVar(value=1.0)

# Frames
top_frame = ttk.Frame(root, padding="10")
top_frame.pack(pady=10, fill="x")

center_frame = ttk.Frame(root, padding="10")
center_frame.pack(pady=10, fill="both", expand=True)

bottom_frame = ttk.Frame(root, padding="10")
bottom_frame.pack(pady=10, fill="x")

# Top Frame Widgets
click_button = ttk.Button(top_frame, text="Click Me!", command=lambda: clicks.set(clicks.get() + click_power.get()))
click_button.pack(pady=20, padx=20, side="left")

click_label = ttk.Label(top_frame, textvariable=clicks, font=("Arial", 24))
click_label.pack(pady=20, padx=20, side="left")

# Center Frame Widgets
# Upgrades
upgrade_frame = ttk.LabelFrame(center_frame, text="Upgrades", padding="10")
upgrade_frame.pack(pady=10, padx=10, fill="both", expand=True)

# Click Power Upgrade
click_power_upgrade_label = ttk.Label(upgrade_frame, text="Click Power:", font=("Arial", 16))
click_power_upgrade_label.grid(row=0, column=0, sticky="w", pady=5)

click_power_upgrade_cost_label = ttk.Label(upgrade_frame, text="Cost: 10", font=("Arial", 16))
click_power_upgrade_cost_label.grid(row=0, column=1, sticky="w", pady=5)

click_power_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(10, click_power, 1, click_power_upgrade_cost_label))
click_power_upgrade_button.grid(row=0, column=2, pady=5)

# Auto Clicker Upgrade
auto_clicker_upgrade_label = ttk.Label(upgrade_frame, text="Auto Clicker:", font=("Arial", 16))
auto_clicker_upgrade_label.grid(row=1, column=0, sticky="w", pady=5)

auto_clicker_upgrade_cost_label = ttk.Label(upgrade_frame, text="Cost: 50", font=("Arial", 16))
auto_clicker_upgrade_cost_label.grid(row=1, column=1, sticky="w", pady=5)

auto_clicker_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(50, auto_clickers, 1, auto_clicker_upgrade_cost_label))
auto_clicker_upgrade_button.grid(row=1, column=2, pady=5)

# Auto Clicker Speed Upgrade
auto_clicker_speed_upgrade_label = ttk.Label(upgrade_frame, text="Auto Clicker Speed:", font=("Arial", 16))
auto_clicker_speed_upgrade_label.grid(row=2, column=0, sticky="w", pady=5)

auto_clicker_speed_upgrade_cost_label = ttk.Label(upgrade_frame, text="Cost: 100", font=("Arial", 16))
auto_clicker_speed_upgrade_cost_label.grid(row=2, column=1, sticky="w", pady=5)

auto_clicker_speed_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(100, auto_clicker_speed, 0.1, auto_clicker_speed_upgrade_cost_label))
auto_clicker_speed_upgrade_button.grid(row=2, column=2, pady=5)

# Python Multiverse Upgrade
python_multiverse_upgrade_label = ttk.Label(upgrade_frame, text="Python Multiverse:", font=("Arial", 16))
python_multiverse_upgrade_label.grid(row=3, column=0, sticky="w", pady=5)

python_multiverse_upgrade_cost_label = ttk.Label(upgrade_frame, text="Cost: 1000", font=("Arial", 16))
python_multiverse_upgrade_cost_label.grid(row=3, column=1, sticky="w", pady=5)

python_multiverse_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(1000, click_power, 10, python_multiverse_upgrade_cost_label))
python_multiverse_upgrade_button.grid(row=3, column=2, pady=5)


# Bottom Frame Widgets
auto_clicker_label = ttk.Label(bottom_frame, text="Auto Clickers:", font=("Arial", 16))
auto_clicker_label.pack(side="left", padx=10)

auto_clicker_count_label = ttk.Label(bottom_frame, textvariable=auto_clickers, font=("Arial", 16))
auto_clicker_count_label.pack(side="left", padx=10)

# Functions
def buy_upgrade(cost, upgrade_variable, upgrade_amount, cost_label):
    if clicks.get() >= cost:
        clicks.set(clicks.get() - cost)
        upgrade_variable.set(upgrade_variable.get() + upgrade_amount)
        # Update cost for next upgrade
        if upgrade_variable == click_power:
            new_cost = int(cost_label.cget("text").split(": ")[1]) * 1.5
            cost_label.config(text=f"Cost: {int(new_cost)}")
        elif upgrade_variable == auto_clickers:
            new_cost = int(cost_label.cget("text").split(": ")[1]) * 2
            cost_label.config(text=f"Cost: {int(new_cost)}")
        elif upgrade_variable == auto_clicker_speed:
            new_cost = int(cost_label.cget("text").split(": ")[1]) * 1.2
            cost_label.config(text=f"Cost: {int(new_cost)}")
        elif upgrade_variable == click_power and upgrade_amount == 10: # Python Multiverse
            new_cost = int(cost_label.cget("text").split(": ")[1]) * 10
            cost_label.config(text=f"Cost: {int(new_cost)}")


def auto_click():
    clicks.set(clicks.get() + auto_clickers.get() * click_power.get())
    root.after(int(1000 / auto_clicker_speed.get()), auto_click)

root.after(int(1000 / auto_clicker_speed.get()), auto_click)

def update_upgrade_cost(cost, upgrade_variable, cost_label):
    if upgrade_variable == click_power:
        new_cost = cost * 1.5
    elif upgrade_variable == auto_clickers:
        new_cost = cost * 2
    elif upgrade_variable == auto_clicker_speed:
        new_cost = cost * 1.2
    elif upgrade_variable == click_power and upgrade_amount == 10: # Python Multiverse
        new_cost = cost * 10
    else:
        new_cost = cost * 1.5  # Default multiplier

    cost_label.config(text=f"Cost: {int(new_cost)}")
    return int(new_cost)

# Re-define buy_upgrade to use the new function
def buy_upgrade(cost, upgrade_variable, upgrade_amount, cost_label):
    if clicks.get() >= cost:
        clicks.set(clicks.get() - cost)
        upgrade_variable.set(upgrade_variable.get() + upgrade_amount)
        new_cost = update_upgrade_cost(cost, upgrade_variable, cost_label)
        # Store the new cost somewhere accessible if needed, or just rely on the label text
        # For simplicity, we'll just update the label text for now.

# Update the lambda functions in the button commands to pass the initial cost
click_power_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(10, click_power, 1, click_power_upgrade_cost_label))
auto_clicker_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(50, auto_clickers, 1, auto_clicker_upgrade_cost_label))
auto_clicker_speed_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(100, auto_clicker_speed, 0.1, auto_clicker_speed_upgrade_cost_label))
python_multiverse_upgrade_button = ttk.Button(upgrade_frame, text="Buy", command=lambda: buy_upgrade(1000, click_power, 10, python_multiverse_upgrade_cost_label))


# Start the auto-clicker loop
root.after(int(1000 / auto_clicker_speed.get()), auto_click)

root.mainloop()

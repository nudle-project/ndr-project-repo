import tkinter as tk
from tkinter import colorchooser, font

def change_background_color():
    color_code = colorchooser.askcolor(title="Choose background color")
    if color_code:
        root.config(bg=color_code[1])
        with open("customization_settings.txt", "w") as f:
            f.write(f"background_color={color_code[1]}\n")

def change_font_color():
    color_code = colorchooser.askcolor(title="Choose font color")
    if color_code:
        text_widget.config(fg=color_code[1])
        with open("customization_settings.txt", "a") as f:
            f.write(f"font_color={color_code[1]}\n")

def change_font_style():
    font_style = font.Font(family="Helvetica", size=12, weight="bold")
    text_widget.config(font=font_style)
    with open("customization_settings.txt", "a") as f:
        f.write(f"font_style={font_style.actual()['family']},{font_style.actual()['size']},{font_style.actual()['weight']}\n")

def load_settings():
    try:
        with open("customization_settings.txt", "r") as f:
            for line in f:
                key, value = line.strip().split("=")
                if key == "background_color":
                    root.config(bg=value)
                elif key == "font_color":
                    text_widget.config(fg=value)
                elif key == "font_style":
                    family, size, weight = value.split(",")
                    text_widget.config(font=(family, int(size), weight))
    except FileNotFoundError:
        pass

root = tk.Tk()
root.title("Terminal Customization")

text_widget = tk.Text(root, wrap="word", height=10, width=50)
text_widget.pack(pady=10)

background_button = tk.Button(root, text="Change Background Color", command=change_background_color)
background_button.pack(pady=5)

font_color_button = tk.Button(root, text="Change Font Color", command=change_font_color)
font_color_button.pack(pady=5)

font_style_button = tk.Button(root, text="Change Font Style", command=change_font_style)
font_style_button.pack(pady=5)

load_settings()

root.mainloop()

import tkinter as tk
from tkinter import ttk
import logging

# Set up logging
logging.basicConfig(filename='calculatorsystem.log', level=logging.INFO, 
                    format='%(asctime)s - %(levelname)s - %(message)s')

class Calculator:
    def __init__(self, master):
        self.master = master
        master.title("Complex Calculator")

        self.total_expression = ""
        self.current_expression = ""

        # Entry field
        self.entry_value = tk.StringVar()
        self.entry = ttk.Entry(master, textvariable=self.entry_value, width=30, font=('Arial', 14), justify='right')
        self.entry.grid(row=0, column=0, columnspan=4, padx=10, pady=10)
        self.entry.focus_set()

        # Result label
        self.result_label = tk.StringVar()
        self.result_label.set("")
        self.result = ttk.Label(master, textvariable=self.result_label, width=30, font=('Arial', 14), justify='right')
        self.result.grid(row=1, column=0, columnspan=4, padx=10)

        # Define buttons
        buttons = [
            ("7", 2, 0), ("8", 2, 1), ("9", 2, 2), ("/", 2, 3),
            ("4", 3, 0), ("5", 3, 1), ("6", 3, 2), ("*", 3, 3),
            ("1", 4, 0), ("2", 4, 1), ("3", 4, 2), ("-", 4, 3),
            ("0", 5, 0), (".", 5, 1), ("=", 5, 2), ("+", 5, 3),
        ]

        # Create and place buttons
        for (text, row, col) in buttons:
            button = ttk.Button(master, text=text, width=5, command=lambda t=text: self.button_click(t))
            button.grid(row=row, column=col, padx=5, pady=5)

        # Clear button
        self.clear_button = ttk.Button(master, text="Clear", width=22, command=self.clear)
        self.clear_button.grid(row=6, column=0, columnspan=2, padx=5, pady=5)

        # All Clear button
        self.all_clear_button = ttk.Button(master, text="All Clear", width=22, command=self.all_clear)
        self.all_clear_button.grid(row=6, column=2, columnspan=2, padx=5, pady=5)
        
        #Coloring the buttons
        style = ttk.Style()
        style.configure("TButton", 
                        padding=6, 
                        relief="flat",
                        background="#000000",
                        foreground="white",
                        font=('Arial', 12))
        
        style.map("TButton",
                  background=[("active", "#000000")])

    def button_click(self, text):
        if text == "=":
            self.evaluate()
        else:
            self.current_expression += text
            self.entry_value.set(self.current_expression)

    def clear(self):
        self.current_expression = ""
        self.entry_value.set("")

    def all_clear(self):
        self.total_expression = ""
        self.current_expression = ""
        self.entry_value.set("")
        self.result_label.set("")

    def evaluate(self):
        self.total_expression += self.current_expression
        try:
            result = eval(self.total_expression)
            self.result_label.set(str(result))
            self.total_expression = str(result)
            self.current_expression = ""
            logging.info(f"Evaluated: {self.total_expression} = {result}")
        except Exception as e:
            self.result_label.set("Error")
            logging.error(f"Error evaluating expression: {e}")
            self.total_expression = ""
            self.current_expression = ""

root = tk.Tk()
calculator = Calculator(root)
root.mainloop()

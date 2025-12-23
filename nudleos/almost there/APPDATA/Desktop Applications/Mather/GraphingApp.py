import tkinter as tk
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
import numpy as np
class GraphingApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Mather - Graphing Application")
        self.root.geometry("800x600")
        self.equation = tk.StringVar()
        self.x_min = tk.DoubleVar(value=-10)
        self.x_max = tk.DoubleVar(value=10)
        self.create_widgets()
    def create_widgets(self):
        equation_label = tk.Label(self.root, text="Equation (e.g., x**2 + sin(x)):")
        equation_label.pack(pady=5)
        equation_entry = tk.Entry(self.root, textvariable=self.equation, width=50)
        equation_entry.pack(pady=5)
        x_min_label = tk.Label(self.root, text="X Min:")
        x_min_label.pack(side=tk.LEFT, padx=5)
        x_min_entry = tk.Entry(self.root, textvariable=self.x_min, width=10)
        x_min_entry.pack(side=tk.LEFT, padx=5)
        x_max_label = tk.Label(self.root, text="X Max:")
        x_max_label.pack(side=tk.LEFT, padx=5)
        x_max_entry = tk.Entry(self.root, textvariable=self.x_max, width=10)
        x_max_entry.pack(side=tk.LEFT, padx=5)
        graph_button = tk.Button(self.root, text="Graph", command=self.plot_graph)
        graph_button.pack(pady=10)
        self.fig, self.ax = plt.subplots()
        self.canvas = FigureCanvasTkAgg(self.fig, master=self.root)
        self.canvas_widget = self.canvas.get_tk_widget()
        self.canvas_widget.pack(fill=tk.BOTH, expand=True)
    def plot_graph(self):
        try:
            equation_str = self.equation.get()
            x_min_val = self.x_min.get()
            x_max_val = self.x_max.get()
            x = np.linspace(x_min_val, x_max_val, 400)
            y = eval(equation_str, {"x": x, "np": np})  
            self.ax.clear()
            self.ax.plot(x, y)
            self.ax.set_xlabel("x")
            self.ax.set_ylabel("y")
            self.ax.set_title("Graph of " + equation_str)
            self.ax.grid(True)
            self.canvas.draw()
        except Exception as e:
            print(f"Error: {e}")
if __name__ == "__main__":
    root = tk.Tk()
    app = GraphingApp(root)
    root.mainloop()

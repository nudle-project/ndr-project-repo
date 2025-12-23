using System;
using System.Windows.Forms;
public class HelloWorld : Form
{
   public HelloWorld()
   {
       Button button = new Button();
       button.Text = "Click Me";
       button.Click += (sender, e) => MessageBox.Show("Hello, World!");
       Controls.Add(button);
   }
   [STAThread]
   public static void Main()
   {
       Application.Run(new HelloWorld());
   }
}
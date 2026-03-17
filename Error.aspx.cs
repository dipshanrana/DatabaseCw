using System;
using System.Web;

namespace DatabaseCw
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ALWAYS show error details in local development so the user knows what's wrong
            pnlDebug.Visible = true;
            
            // Try to get error from Server.GetLastError() (works with Server.Transfer)
            Exception lastError = Server.GetLastError();
            
            // If that's null, check if we arrived here via Redirect and might have stored it elsewhere
            if (lastError == null && Context.Items["LastError"] != null)
            {
                lastError = (Exception)Context.Items["LastError"];
            }

            if (lastError != null)
            {
                // Unpack InnerException if it's TargetInvocationException or similar
                if (lastError.InnerException != null)
                {
                    lblError.Text = "<strong>" + lastError.Message + "</strong><br/>" + lastError.InnerException.Message;
                }
                else
                {
                    lblError.Text = lastError.Message;
                }
            }
            else
            {
                lblError.Text = "An unknown error occurred. No exception details were captured.";
            }
        }
    }
}

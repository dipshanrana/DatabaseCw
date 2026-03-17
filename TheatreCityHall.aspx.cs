using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DatabaseCw
{
    public partial class TheatreCityHall : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlMessage.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            FormView1.PageIndex = GridView1.SelectedIndex + (GridView1.PageIndex * GridView1.PageSize);
            FormView1.ChangeMode(FormViewMode.Edit);
            pnlMessage.Visible = false;
        }

        protected void DataSource_Error(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                pnlMessage.Visible = true;
                divMessage.Attributes["class"] = "alert alert-error";

                if (e.Exception.Message.Contains("ORA-00001"))
                    lblMessage.Text = "<strong>Error:</strong> This Theatre ID already exists.";
                else if (e.Exception.Message.Contains("ORA-02292"))
                    lblMessage.Text = "<strong>Error:</strong> Cannot delete theatre. It still has active halls, shows, or tickets.";
                else
                    lblMessage.Text = "<strong>Database Error:</strong> " + e.Exception.Message;

                e.ExceptionHandled = true;
            }
            else
            {
                pnlMessage.Visible = true;
                divMessage.Attributes["class"] = "alert alert-success";
                lblMessage.Text = "<strong>Success!</strong> Theatre registry updated.";
            }
        }
    }
}
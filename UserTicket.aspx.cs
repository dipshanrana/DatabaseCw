using Oracle.ManagedDataAccess.Client;
using System;
using System.Configuration;
using System.Data;
using System.Web.UI.WebControls;

namespace DatabaseCw
{
    public partial class UserTicket : System.Web.UI.Page
    {


        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString2"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
                pnlNoData.Visible = true;
            }
        }

        private void LoadUsers()
        {
            try
            {
                using (OracleConnection conn = new OracleConnection(connStr))
                {
                    conn.Open();
                    string sql = "SELECT \"USERID\", \"USERNAME\" FROM \"USERS\" ORDER BY \"USERNAME\"";
                    OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlUser.DataSource = dt;
                    ddlUser.DataTextField = "USERNAME";
                    ddlUser.DataValueField = "USERID";
                    ddlUser.DataBind();
                    ddlUser.Items.Insert(0, new ListItem("-- Select a User --", ""));
                }
            }
            catch (Exception ex)
            {
                ShowError("Failed to load users: " + ex.Message);
                ddlUser.Items.Clear();
                ddlUser.Items.Add(new ListItem("-- Database Unavailable --", ""));
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            pnlError.Visible = false;

            if (string.IsNullOrEmpty(ddlUser.SelectedValue))
            {
                pnlUserInfo.Visible = false;
                pnlNoData.Visible = true;
                return;
            }

            try
            {
                int userId = int.Parse(ddlUser.SelectedValue);
                LoadUserInfo(userId);
                LoadUserTickets(userId);
                pnlUserInfo.Visible = true;
                pnlNoData.Visible = false;
            }
            catch (Exception ex)
            {
                ShowError("Failed to fetch user data: " + ex.Message);
                pnlUserInfo.Visible = false;
                pnlNoData.Visible = true;
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            lblErrorMessage.Text = "<strong>Error:</strong> " + message;
        }

        private void LoadUserInfo(int userId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT \"USERID\", \"USERNAME\", \"USERADDRESS\", \"USEREMAIL\", \"USERPHONE\" FROM \"USERS\" WHERE \"USERID\" = :p_userid";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.Add("p_userid", OracleDbType.Int32).Value = userId;
                OracleDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblUserId.Text = dr["USERID"].ToString();
                    lblUserName.Text = dr["USERNAME"].ToString();
                    lblUserAddress.Text = dr["USERADDRESS"].ToString();
                    lblUserEmail.Text = dr["USEREMAIL"].ToString();
                    lblUserPhone.Text = dr["USERPHONE"].ToString();
                }
            }
        }

        private void LoadUserTickets(int userId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = @"
                    SELECT 
                        t.""TICKETID"",
                        b.""BOOKINGID"",
                        m.""MOVIETITLE"",
                        th.""THEATRENAME"",
                        th.""THEATRECITY"",
                        s.""SHOWDATE"",
                        s.""SHOWTIME"",
                        se.""SEATNO"",
                        se.""SEATPRICE"",
                        t.""TICKETSTATUS"",
                        t.""BOOKEDAT""
                    FROM ""TICKETS"" t
                    JOIN ""BOOKINGS"" b ON t.""BOOKINGID"" = b.""BOOKINGID""
                    JOIN ""SHOWS"" s ON b.""SHOWID"" = s.""SHOWID""
                    JOIN ""MOVIES"" m ON s.""MOVIEID"" = m.""MOVIEID""
                    JOIN ""HALLS"" h ON s.""HALLID"" = h.""HALLID""
                    JOIN ""THEATRES"" th ON h.""THEATREID"" = th.""THEATREID""
                    JOIN ""SEATS"" se ON t.""SEATID"" = se.""SEATID""
                    WHERE b.""USERID"" = :p_userid
                      AND b.""BOOKINGDATETIME"" >= ADD_MONTHS(SYSDATE, -6)
                    ORDER BY t.""BOOKEDAT"" DESC";

                OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                da.SelectCommand.Parameters.Add("p_userid", OracleDbType.Int32).Value = userId;
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUserTickets.DataSource = dt;
                gvUserTickets.DataBind();

                lblTotalTickets.Text = dt.Rows.Count.ToString();

                // Get totals
                decimal totalPaid = 0;
                int bookingCount = 0;
                if (dt.Rows.Count > 0)
                {
                    // Count distinct bookings
                    DataView dv = new DataView(dt);
                    DataTable dtDistinct = dv.ToTable(true, "BOOKINGID");
                    bookingCount = dtDistinct.Rows.Count;

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["TICKETSTATUS"].ToString().ToUpper() == "PAID" ||
                            row["TICKETSTATUS"].ToString().ToUpper() == "BOOKED")
                        {
                            decimal price;
                            if (decimal.TryParse(row["SEATPRICE"].ToString(), out price))
                                totalPaid += price;
                        }
                    }
                }
                lblTotalPaid.Text = totalPaid.ToString("N0");
                lblTotalBookings.Text = bookingCount.ToString();
            }
        }

        public string GetStatusBadge(string status)
        {
            switch (status?.ToUpper())
            {
                case "PAID": return "badge-paid";
                case "BOOKED": return "badge-booked";
                case "CANCELLED": return "badge-cancelled";
                default: return "badge-booked";
            }
        }
    }
}

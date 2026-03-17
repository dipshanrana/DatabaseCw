using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace DatabaseCw
{
    public partial class TheatreCityHallMovie : System.Web.UI.Page
    {


        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString2"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTheatres();
                pnlHallInfo.Visible = false;
                pnlNoData.Visible = true;
            }
        }

        private void LoadTheatres()
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT THEATREID, THEATRENAME || ' - ' || THEATRECITY AS DISPLAYNAME FROM THEATRES ORDER BY THEATRENAME";
                OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlTheatre.DataSource = dt;
                ddlTheatre.DataTextField = "DISPLAYNAME";
                ddlTheatre.DataValueField = "THEATREID";
                ddlTheatre.DataBind();
                ddlTheatre.Items.Insert(0, new ListItem("-- Select a Theatre --", ""));

                // Load halls for first theatre if exists
                if (dt.Rows.Count > 0)
                {
                    LoadHalls(dt.Rows[0]["THEATREID"].ToString());
                }
            }
        }

        private void LoadHalls(string theatreId)
        {
            ddlHall.Items.Clear();
            if (string.IsNullOrEmpty(theatreId))
            {
                ddlHall.Items.Add(new ListItem("-- Select Hall --", ""));
                return;
            }               
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                 conn.Open();
                string sql = "SELECT HALLID, 'Hall ' || HALLNUMBER || ' (Cap: ' || HALLCAPACITY || ')' AS DISPLAYNAME FROM HALLS WHERE THEATREID = :tid ORDER BY HALLNUMBER";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.Add("tid", OracleDbType.Int32).Value = int.Parse(theatreId);
                OracleDataAdapter da = new OracleDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlHall.DataSource = dt;
                ddlHall.DataTextField = "DISPLAYNAME";
                ddlHall.DataValueField = "HALLID";
                ddlHall.DataBind();
                ddlHall.Items.Insert(0, new ListItem("-- Select Hall --", ""));
            }
        }

        protected void ddlTheatre_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadHalls(ddlTheatre.SelectedValue);
            pnlHallInfo.Visible = false;
            pnlNoData.Visible = true;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlHall.SelectedValue))
            {
                pnlHallInfo.Visible = false;
                pnlNoData.Visible = true;
                return;
            }

            int hallId = int.Parse(ddlHall.SelectedValue);
            LoadHallInfo(hallId);
            LoadMoviesAndShowtimes(hallId);
            pnlHallInfo.Visible = true;
            pnlNoData.Visible = false;
        }

        private void LoadHallInfo(int hallId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT h.HALLID, h.HALLNUMBER, h.HALLCAPACITY, t.THEATRENAME, t.THEATRECITY
                               FROM HALLS h JOIN THEATRES t ON h.THEATREID = t.THEATREID
                               WHERE h.HALLID = :hid";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.Add("hid", OracleDbType.Int32).Value = hallId;
                OracleDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTheatreName.Text = dr["THEATRENAME"].ToString();
                    lblTheatreCity.Text = dr["THEATRECITY"].ToString();
                    lblHallNumber.Text = dr["HALLNUMBER"].ToString();
                    lblHallCapacity.Text = dr["HALLCAPACITY"].ToString();
                }
            }
        }

        private void LoadMoviesAndShowtimes(int hallId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = @"
                    SELECT 
                        s.SHOWID,
                        m.MOVIETITLE,
                        m.MOVIEGENRE,
                        m.MOVIELANGUAGE,
                        m.MOVIEDURATION,
                        s.SHOWDATE,
                        s.SHOWTIME,
                        se.MINPRICE AS TICKETPRICE
                    FROM SHOWS s
                    JOIN MOVIES m ON s.MOVIEID = m.MOVIEID
                    LEFT JOIN (
                        SELECT HALLID, MIN(SEATPRICE) AS MINPRICE 
                        FROM SEATS GROUP BY HALLID
                    ) se ON s.HALLID = se.HALLID
                    WHERE s.HALLID = :hid
                    ORDER BY s.SHOWDATE, s.SHOWTIME";

                OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                da.SelectCommand.Parameters.Add("hid", OracleDbType.Int32).Value = hallId;
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvMovieShowtime.DataSource = dt;
                gvMovieShowtime.DataBind();
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.ManagedDataAccess.Client;

namespace DatabaseCw
{
    public partial class MovieTheatreOccupancy : System.Web.UI.Page
    {


        string connStr = ConfigurationManager.ConnectionStrings["ConnectionString2"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
                pnlMovieInfo.Visible = false;
                pnlNoData.Visible = true;
            }
        }

        private void LoadMovies()
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT MOVIEID, MOVIETITLE || ' (' || MOVIEGENRE || ')' AS DISPLAYNAME FROM MOVIES ORDER BY MOVIETITLE";
                OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlMovie.DataSource = dt;
                ddlMovie.DataTextField = "DISPLAYNAME";
                ddlMovie.DataValueField = "MOVIEID";
                ddlMovie.DataBind();
                ddlMovie.Items.Insert(0, new ListItem("-- Select a Movie --", ""));
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlMovie.SelectedValue))
            {
                pnlMovieInfo.Visible = false;
                pnlNoData.Visible = true;
                return;
            }

            try
            {
                int movieId = int.Parse(ddlMovie.SelectedValue);
                LoadMovieInfo(movieId);
                LoadTop3Occupancy(movieId);
                pnlMovieInfo.Visible = true;
                pnlNoData.Visible = false;
                pnlError.Visible = false;
            }
            catch (Exception ex)
            {
                ShowError("Failed to fetch occupancy data: " + ex.Message);
                pnlMovieInfo.Visible = false;
                pnlNoData.Visible = true;
            }
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            lblErrorMessage.Text = "<strong>Error:</strong> " + message;
        }

        private void LoadMovieInfo(int movieId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                string sql = "SELECT MOVIEID, MOVIETITLE, MOVIEGENRE, MOVIELANGUAGE, MOVIEDURATION, MOVIERELEASEDATE FROM MOVIES WHERE MOVIEID = :mid";
                OracleCommand cmd = new OracleCommand(sql, conn);
                cmd.Parameters.Add("mid", OracleDbType.Int32).Value = movieId;
                OracleDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblMovieId.Text = dr["MOVIEID"].ToString();
                    lblMovieTitle.Text = dr["MOVIETITLE"].ToString();
                    lblMovieGenre.Text = dr["MOVIEGENRE"].ToString();
                    lblMovieLang.Text = dr["MOVIELANGUAGE"].ToString();
                    lblMovieDuration.Text = dr["MOVIEDURATION"].ToString();
                    object releaseDate = dr["MOVIERELEASEDATE"];
                    if (releaseDate != DBNull.Value)
                        lblMovieRelease.Text = Convert.ToDateTime(releaseDate).ToString("dd/MM/yyyy");
                    else
                        lblMovieRelease.Text = "N/A";
                }
            }
        }

        private void LoadTop3Occupancy(int movieId)
        {
            using (OracleConnection conn = new OracleConnection(connStr))
            {
                conn.Open();
                // Get top 3 halls with max seat occupancy for active/paid tickets
                // Occupancy = total tickets / (hall capacity * number of shows)
                string sql = @"
                    SELECT * FROM (
                        SELECT 
                            th.THEATRENAME,
                            th.THEATRECITY,
                            h.HALLNUMBER,
                            h.HALLCAPACITY,
                            COUNT(t.TICKETID) AS PAIDTICKETS,
                            COUNT(DISTINCT s.SHOWID) AS TOTALSHOWS,
                            ROUND(COUNT(t.TICKETID) * 100.0 / (h.HALLCAPACITY * COUNT(DISTINCT s.SHOWID)), 2) AS OCCUPANCYPCT
                        FROM SHOWS s
                        JOIN HALLS h ON s.HALLID = h.HALLID
                        JOIN THEATRES th ON h.THEATREID = th.THEATREID
                        LEFT JOIN BOOKINGS b ON b.SHOWID = s.SHOWID
                        LEFT JOIN TICKETS t ON t.BOOKINGID = b.BOOKINGID AND UPPER(t.TICKETSTATUS) NOT IN ('CANCELLED', 'REFUNDED')
                        WHERE s.MOVIEID = :mid
                        GROUP BY th.THEATRENAME, th.THEATRECITY, h.HALLNUMBER, h.HALLCAPACITY
                        ORDER BY OCCUPANCYPCT DESC
                    ) WHERE ROWNUM <= 3";

                OracleDataAdapter da = new OracleDataAdapter(sql, conn);
                da.SelectCommand.Parameters.Add("mid", OracleDbType.Int32).Value = movieId;
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptTop3.DataSource = dt;
                    rptTop3.DataBind();
                    pnlTop3.Visible = true;
                    pnlNoResults.Visible = false;
                }
                else
                {
                    pnlTop3.Visible = false;
                    pnlNoResults.Visible = true;
                }
            }
        }

        protected void rptTop3_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // Additional item-level data binding if needed
        }

        public string GetBarStyle(object pct)
        {
            double val = 0;
            if (pct != null && pct != DBNull.Value)
                double.TryParse(pct.ToString(), out val);
            val = Math.Min(val, 100);
            return "width: " + val.ToString("F1") + "%;";
        }
    }
}

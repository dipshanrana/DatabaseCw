<%@ Page Title="Theatre Hall Movies" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TheatreCityHallMovie.aspx.cs" Inherits="DatabaseCw.TheatreCityHallMovie" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <style>
            .page-header {
                margin-bottom: 24px;
            }

            .page-header h2 {
                margin: 0;
                font-size: 1.25rem;
                font-weight: 700;
                color: #111;
            }

            .page-header p {
                margin: 4px 0 0;
                color: #888;
                font-size: 0.88rem;
            }

            .filter-box {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 18px 22px;
                margin-bottom: 24px;
                display: flex;
                align-items: flex-end;
                gap: 16px;
                flex-wrap: wrap;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .filter-group label {
                font-size: 0.82rem;
                font-weight: 700;
                color: #444;
            }

            .filter-box select {
                padding: 9px 12px;
                border: 1px solid #ccc;
                border-radius: 3px;
                font-size: 0.88rem;
                min-width: 220px;
            }

            .filter-box select:focus {
                border-color: #c0392b;
                outline: none;
            }

            .btn-primary {
                background: #c0392b;
                color: #fff;
                border: none;
                padding: 10px 24px;
                border-radius: 3px;
                font-size: 0.88rem;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.2s;
            }

            .btn-primary:hover {
                background: #a93226;
            }

            .hall-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 20px 24px;
                margin-bottom: 20px;
                border-left: 4px solid #c0392b;
            }

            .hall-card h3 {
                margin: 0 0 14px;
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 1.2px;
                color: #999;
                font-weight: 700;
            }

            .info-row {
                display: flex;
                flex-wrap: wrap;
                gap: 24px;
            }

            .info-cell .lbl {
                font-size: 0.7rem;
                text-transform: uppercase;
                color: #aaa;
                margin-bottom: 2px;
                font-weight: 600;
            }

            .info-cell .val {
                font-size: 0.9rem;
                font-weight: 600;
                color: #222;
            }

            .results-box {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                overflow: hidden;
            }

            .results-box h3 {
                margin: 0;
                font-size: 0.82rem;
                text-transform: uppercase;
                color: #666;
                font-weight: 700;
                padding: 14px 20px;
                border-bottom: 1px solid #eee;
                background: #fafafa;
            }

            .table-wrap {
                overflow-x: auto;
            }

            .data-table {
                width: 100%;
                border-collapse: collapse;
                font-size: 0.85rem;
            }

            .data-table th {
                background: #1a1a1a;
                color: #fff;
                padding: 12px 14px;
                text-align: left;
                font-weight: 600;
                font-size: 0.78rem;
                border-bottom: 2px solid #c0392b;
            }

            .data-table th a {
                color: #fff;
                text-decoration: none;
            }

            .data-table th a:hover {
                color: #fff;
                text-decoration: underline;
            }

            .data-table td {
                padding: 12px 14px;
                border-bottom: 1px solid #f0f0f0;
                color: #333;
            }

            .data-table tr:hover td {
                background: #fbfbfb;
            }

            .empty-msg {
                padding: 40px;
                text-align: center;
                color: #999;
                font-size: 0.9rem;
            }
        </style>

        <div class="page-header">
            <h2>Theatre Hall Movies Report</h2>
            <p>View scheduled movies and showtimes for a specific hall</p>
        </div>

        <div class="filter-box">
            <div class="filter-group">
                <label>Theatre:</label>
                <asp:DropDownList ID="ddlTheatre" runat="server" AutoPostBack="True"
                    OnSelectedIndexChanged="ddlTheatre_SelectedIndexChanged"></asp:DropDownList>
            </div>
            <div class="filter-group">
                <label>Hall:</label>
                <asp:DropDownList ID="ddlHall" runat="server"></asp:DropDownList>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Show Schedule" CssClass="btn-primary"
                OnClick="btnSearch_Click" />
        </div>

        <asp:Panel ID="pnlHallInfo" runat="server" Visible="false">
            <div class="hall-card">
                <h3>Hall Specifications</h3>
                <div class="info-row">
                    <div class="info-cell">
                        <div class="lbl">Theatre Name</div>
                        <div class="val">
                            <asp:Label ID="lblTheatreName" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">City</div>
                        <div class="val">
                            <asp:Label ID="lblTheatreCity" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Hall Number</div>
                        <div class="val">
                            <asp:Label ID="lblHallNumber" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Seating Capacity</div>
                        <div class="val">
                            <asp:Label ID="lblHallCapacity" runat="server" /> seats
                        </div>
                    </div>
                </div>
            </div>

            <div class="results-box">
                <h3>Scheduled Movie Lineup</h3>
                <div class="table-wrap">
                    <asp:GridView ID="gvMovieShowtime" runat="server" AutoGenerateColumns="False" CssClass="data-table"
                        GridLines="None" EmptyDataText="No movies found for this hall.">
                        <EmptyDataRowStyle CssClass="empty-msg" />
                        <Columns>
                            <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie Title" />
                            <asp:BoundField DataField="MOVIEGENRE" HeaderText="Genre" />
                            <asp:BoundField DataField="MOVIELANGUAGE" HeaderText="Language" />
                            <asp:BoundField DataField="MOVIEDURATION" HeaderText="Min." />
                            <asp:BoundField DataField="SHOWDATE" HeaderText="Show Date"
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="SHOWTIME" HeaderText="Show Time" />
                            <asp:BoundField DataField="TICKETPRICE" HeaderText="Min Price (Rs.)"
                                DataFormatString="{0:N0}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoData" runat="server" Visible="true">
            <div class="results-box">
                <div class="empty-msg">Select a theatre and hall, then click Show Schedule to view details.</div>
            </div>
        </asp:Panel>
    </asp:Content>
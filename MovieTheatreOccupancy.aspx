<%@ Page Title="Movie Occupancy Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MovieTheatreOccupancy.aspx.cs" Inherits="DatabaseCw.MovieTheatreOccupancy" %>

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
                min-width: 280px;
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

            .movie-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 20px 24px;
                margin-bottom: 20px;
                border-left: 4px solid #c0392b;
            }

            .movie-card h3 {
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

            .note-bar {
                background: #fff8e1;
                border: 1px solid #ffe082;
                border-radius: 4px;
                padding: 12px 16px;
                margin-bottom: 24px;
                font-size: 0.85rem;
                color: #795548;
                display: flex;
                align-items: center;
                gap: 8px;
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

            .results-body {
                padding: 20px;
            }

            .rank-item {
                background: #fff;
                border: 1px solid #eee;
                border-radius: 4px;
                margin-bottom: 14px;
                overflow: hidden;
            }

            .rank-header {
                display: flex;
                align-items: center;
                padding: 16px 20px;
                background: #fdfdfd;
                border-bottom: 1px solid #f5f5f5;
                gap: 16px;
            }

            .rank-num {
                font-size: 1.2rem;
                font-weight: 800;
                color: #ddd;
                min-width: 32px;
            }

            .rank-1 .rank-num {
                color: #fbc02d;
            }

            .rank-2 .rank-num {
                color: #9e9e9e;
            }

            .rank-3 .rank-num {
                color: #a1887f;
            }

            .rank-info {
                flex: 1;
            }

            .rank-info .name {
                font-weight: 700;
                color: #111;
                font-size: 0.95rem;
            }

            .rank-info .sub {
                font-size: 0.78rem;
                color: #888;
                margin-top: 2px;
            }

            .rank-stat {
                text-align: right;
            }

            .rank-stat .val {
                font-size: 1.4rem;
                font-weight: 800;
                color: #c0392b;
            }

            .rank-stat .lbl {
                font-size: 0.65rem;
                color: #aaa;
                text-transform: uppercase;
            }

            .rank-body {
                display: flex;
                background: #fff;
            }

            .detail-box {
                padding: 12px 20px;
                border-right: 1px solid #f5f5f5;
                flex: 1;
            }

            .detail-box:last-child {
                border-right: none;
            }

            .detail-box .d-lbl {
                font-size: 0.68rem;
                text-transform: uppercase;
                color: #aaa;
                font-weight: 600;
                margin-bottom: 4px;
            }

            .detail-box .d-val {
                font-size: 0.85rem;
                font-weight: 600;
                color: #333;
            }

            .bar-bg {
                background: #f0f0f0;
                height: 6px;
                border-radius: 10px;
                margin-top: 8px;
                overflow: hidden;
            }

            .bar-fill {
                height: 100%;
                background: #c0392b;
                border-radius: 10px;
            }

            .empty-msg {
                padding: 40px;
                text-align: center;
                color: #999;
                font-size: 0.9rem;
            }
        </style>

        <div class="page-header">
            <h2>Movie Theatre Occupancy</h2>
            <p>Top 3 performing halls based on seat occupancy for a selected film</p>
        </div>

        <div class="filter-box">
            <div class="filter-group">
                <label>Select Movie:</label>
                <asp:DropDownList ID="ddlMovie" runat="server"></asp:DropDownList>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Analyze Occupancy" CssClass="btn-primary"
                OnClick="btnSearch_Click" />
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false" style="margin-bottom: 20px;">
            <div
                style="background:#fce8e6; color:#c5221f; padding:12px 20px; border-radius:4px; font-size: 0.88rem; border-left: 4px solid #c5221f;">
                <asp:Label ID="lblErrorMessage" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlMovieInfo" runat="server" Visible="false">
            <div class="movie-card">
                <h3>Movie Profile</h3>
                <div class="info-row">
                    <div class="info-cell">
                        <div class="lbl">Movie ID</div>
                        <div class="val">
                            <asp:Label ID="lblMovieId" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Movie Title</div>
                        <div class="val">
                            <asp:Label ID="lblMovieTitle" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Genre</div>
                        <div class="val">
                            <asp:Label ID="lblMovieGenre" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Language</div>
                        <div class="val">
                            <asp:Label ID="lblMovieLang" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Duration</div>
                        <div class="val">
                            <asp:Label ID="lblMovieDuration" runat="server" /> min
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Release Date</div>
                        <div class="val">
                            <asp:Label ID="lblMovieRelease" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="note-bar">
                <span>ℹ️</span> Occupancy is calculated as (Total Paid Tickets) / (Total Seating Capacity) across all
                shows.
            </div>

            <div class="results-box">
                <h3>Top 3 Hall Performance</h3>
                <div class="results-body">
                    <asp:Panel ID="pnlTop3" runat="server">
                        <asp:Repeater ID="rptTop3" runat="server" OnItemDataBound="rptTop3_ItemDataBound">
                            <ItemTemplate>
                                <div class='rank-item rank-<%# Container.ItemIndex + 1 %>'>
                                    <div class="rank-header">
                                        <div class="rank-num">#<%# Container.ItemIndex + 1 %>
                                        </div>
                                        <div class="rank-info">
                                            <div class="name">
                                                <%# Eval("THEATRENAME") %>
                                            </div>
                                            <div class="sub">
                                                <%# Eval("THEATRECITY") %> &mdash; Hall <%# Eval("HALLNUMBER") %>
                                            </div>
                                        </div>
                                        <div class="rank-stat">
                                            <div class="val">
                                                <%# Eval("OCCUPANCYPCT", "{0:N1}" ) %>%
                                            </div>
                                            <div class="lbl">Occupancy</div>
                                        </div>
                                    </div>
                                    <div class="rank-body">
                                        <div class="detail-box">
                                            <div class="d-lbl">Hall Capacity</div>
                                            <div class="d-val">
                                                <%# Eval("HALLCAPACITY") %> seats
                                            </div>
                                        </div>
                                        <div class="detail-box">
                                            <div class="d-lbl">Paid Tickets</div>
                                            <div class="d-val">
                                                <%# Eval("PAIDTICKETS") %> sold
                                            </div>
                                        </div>
                                        <div class="detail-box">
                                            <div class="d-lbl">Total Shows</div>
                                            <div class="d-val">
                                                <%# Eval("TOTALSHOWS") %> screenings
                                            </div>
                                        </div>
                                        <div class="detail-box">
                                            <div class="d-lbl">Coverage</div>
                                            <div class="bar-bg">
                                                <div class="bar-fill" style='<%# GetBarStyle(Eval("OCCUPANCYPCT")) %>'>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </asp:Panel>
                    <asp:Panel ID="pnlNoResults" runat="server" Visible="false">
                        <div class="empty-msg">No ticket sales data found for this movie yet.</div>
                    </asp:Panel>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoData" runat="server" Visible="true">
            <div class="results-box">
                <div class="empty-msg">Select a movie and click Analyze to view performance data.</div>
            </div>
        </asp:Panel>
    </asp:Content>
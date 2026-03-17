<%@ Page Title="User Ticket Report" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UserTicket.aspx.cs" Inherits="DatabaseCw.UserTicket" %>

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
                min-width: 260px;
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

            .user-card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 20px 24px;
                margin-bottom: 20px;
                border-left: 4px solid #c0392b;
            }

            .user-card h3 {
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

            .stats-row {
                display: flex;
                gap: 14px;
                margin-bottom: 24px;
                flex-wrap: wrap;
            }

            .stat-box {
                background: #1a1a1a;
                color: #fff;
                padding: 16px 20px;
                border-radius: 4px;
                flex: 1;
                min-width: 160px;
            }

            .stat-box .s-label {
                font-size: 0.68rem;
                text-transform: uppercase;
                color: #888;
                letter-spacing: 0.5px;
            }

            .stat-box .s-val {
                font-size: 1.4rem;
                font-weight: 700;
                margin-top: 4px;
                color: #fff;
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

            .badge {
                display: inline-block;
                padding: 3px 10px;
                border-radius: 3px;
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
            }

            .b-paid {
                background: #e6f4ea;
                color: #1e7e34;
            }

            .b-booked {
                background: #e8f0fe;
                color: #1967d2;
            }

            .b-cancelled {
                background: #fce8e6;
                color: #c5221f;
            }

            .empty-msg {
                padding: 40px;
                text-align: center;
                color: #999;
                font-size: 0.9rem;
            }
        </style>

        <div class="page-header">
            <h2>User Ticket Report</h2>
            <p>Purchase history and engagement stats for the last 6 months</p>
        </div>

        <div class="filter-box">
            <div class="filter-group">
                <label>Select User:</label>
                <asp:DropDownList ID="ddlUser" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Generate Report" CssClass="btn-primary"
                OnClick="btnSearch_Click" />
        </div>

        <asp:Panel ID="pnlError" runat="server" Visible="false" style="margin-bottom: 20px;">
            <div
                style="background:#fce8e6; color:#c5221f; padding:12px 20px; border-radius:4px; font-size: 0.88rem; border-left: 4px solid #c5221f;">
                <asp:Label ID="lblErrorMessage" runat="server" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlUserInfo" runat="server" Visible="false">
            <div class="user-card">
                <h3>Customer Profile</h3>
                <div class="info-row">
                    <div class="info-cell">
                        <div class="lbl">User ID</div>
                        <div class="val">
                            <asp:Label ID="lblUserId" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Full Name</div>
                        <div class="val">
                            <asp:Label ID="lblUserName" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Email</div>
                        <div class="val">
                            <asp:Label ID="lblUserEmail" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Contact</div>
                        <div class="val">
                            <asp:Label ID="lblUserPhone" runat="server" />
                        </div>
                    </div>
                    <div class="info-cell">
                        <div class="lbl">Location</div>
                        <div class="val">
                            <asp:Label ID="lblUserAddress" runat="server" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="stats-row">
                <div class="stat-box">
                    <div class="s-label">Active Tickets</div>
                    <div class="s-val">
                        <asp:Label ID="lblTotalTickets" runat="server" Text="0" />
                    </div>
                </div>
                <div class="stat-box">
                    <div class="s-label">Total Spend (Rs.)</div>
                    <div class="s-val">
                        <asp:Label ID="lblTotalPaid" runat="server" Text="0" />
                    </div>
                </div>
                <div class="stat-box">
                    <div class="s-label">Total Bookings</div>
                    <div class="s-val">
                        <asp:Label ID="lblTotalBookings" runat="server" Text="0" />
                    </div>
                </div>
            </div>

            <div class="results-box">
                <h3>Recent Ticket History (6 Months)</h3>
                <div class="table-wrap">
                    <asp:GridView ID="gvUserTickets" runat="server" AutoGenerateColumns="False" CssClass="data-table"
                        GridLines="None" EmptyDataText="No tickets found for this period.">
                        <EmptyDataRowStyle CssClass="empty-msg" />
                        <Columns>
                            <asp:BoundField DataField="TICKETID" HeaderText="Ticket #" />
                            <asp:BoundField DataField="MOVIETITLE" HeaderText="Movie" />
                            <asp:BoundField DataField="THEATRENAME" HeaderText="Theatre" />
                            <asp:BoundField DataField="SHOWDATE" HeaderText="Date" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="SHOWTIME" HeaderText="Time" />
                            <asp:BoundField DataField="SEATNO" HeaderText="Seat" />
                            <asp:BoundField DataField="SEATPRICE" HeaderText="Price" DataFormatString="{0:N0}" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='badge <%# GetStatusBadge(Eval("TICKETSTATUS").ToString()) %>'>
                                        <%# Eval("TICKETSTATUS") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="BOOKEDAT" HeaderText="Booked On"
                                DataFormatString="{0:dd/MM HH:mm}" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlNoData" runat="server" Visible="true">
            <div class="results-box">
                <div class="empty-msg">Please select a user and click Generate Report to see details.</div>
            </div>
        </asp:Panel>
    </asp:Content>
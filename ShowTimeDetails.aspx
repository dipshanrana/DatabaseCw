<%@ Page Title="Showtime Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ShowTimeDetails.aspx.cs" Inherits="DatabaseCw.ShowTimeDetails" %>

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

            .form-grid {
                display: grid;
                grid-template-columns: 350px 1fr;
                gap: 24px;
                align-items: start;
            }

            @media (max-width: 992px) {
                .form-grid {
                    grid-template-columns: 1fr;
                }
            }

            .card {
                background: #fff;
                border: 1px solid #ddd;
                border-radius: 4px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .card-header {
                padding: 14px 20px;
                background: #fafafa;
                border-bottom: 1px solid #eee;
            }

            .card-header h3 {
                margin: 0;
                font-size: 0.82rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: #666;
                font-weight: 700;
            }

            .card-body {
                padding: 20px;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-group label {
                display: block;
                font-size: 0.82rem;
                font-weight: 600;
                color: #444;
                margin-bottom: 6px;
            }

            .form-control {
                width: 100%;
                padding: 9px 12px;
                font-size: 0.88rem;
                border: 1px solid #ccc;
                border-radius: 3px;
                font-family: inherit;
                color: #333;
            }

            .form-control:focus {
                border-color: #c0392b;
                outline: none;
                box-shadow: 0 0 0 2px rgba(192, 57, 43, 0.1);
            }

            .validation-msg {
                color: #c5221f;
                font-size: 0.75rem;
                display: block;
                margin-top: 4px;
                font-weight: 500;
            }

            .btn-link {
                display: inline-block;
                padding: 9px 20px;
                font-size: 0.85rem;
                font-weight: 600;
                text-decoration: none;
                border-radius: 3px;
                cursor: pointer;
                transition: all 0.2s;
                text-align: center;
            }

            .btn-add {
                background: #c0392b;
                color: #fff !important;
                border: none;
            }

            .btn-add:hover {
                background: #a93226;
            }

            .btn-secondary {
                background: #f5f5f5;
                color: #444 !important;
                border: 1px solid #ddd;
                margin-left: 8px;
            }

            .btn-secondary:hover {
                background: #eee;
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

            .action-link {
                color: #c0392b;
                text-decoration: none;
                font-weight: 600;
                margin-right: 12px;
                font-size: 0.8rem;
            }

            .action-link:hover {
                color: #a93226;
                text-decoration: underline;
            }

            .alert {
                padding: 12px 20px;
                border-radius: 4px;
                font-size: 0.88rem;
                margin-bottom: 24px;
                border-left: 4px solid;
            }

            .alert-error {
                background: #fce8e6;
                color: #c5221f;
                border-color: #c5221f;
            }

            .alert-success {
                background: #e6f4ea;
                color: #1e7e34;
                border-color: #1e7e34;
            }
        </style>

        <div class="page-header">
            <h2>Showtime Management</h2>
            <p>Schedule movie screenings across different halls</p>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <div id="divMessage" runat="server" class="alert">
                <asp:Label ID="lblMessage" runat="server" />
            </div>
        </asp:Panel>

        <div class="form-grid">
            <div class="card">
                <div class="card-header">
                    <h3>Schedule Show</h3>
                </div>
                <div class="card-body">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1"
                        DefaultMode="Insert" Width="100%" AllowPaging="True">
                        <PagerSettings Visible="False" />
                        <EditItemTemplate>
                            <div class="form-group">
                                <label>Show ID:</label>
                                <asp:Label ID="SHOWIDLabel" runat="server" Text='<%# Eval("SHOWID") %>'
                                    CssClass="form-control" style="background:#f9f9f9;" />
                            </div>
                            <div class="form-group">
                                <label>Movie ID:</label>
                                <asp:TextBox ID="MOVIEIDTextBox" runat="server" Text='<%# Bind("MOVIEID") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvMovieEdit" runat="server"
                                    ControlToValidate="MOVIEIDTextBox" ErrorMessage="Movie ID is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvMovieEdit" runat="server" ControlToValidate="MOVIEIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Hall ID:</label>
                                <asp:TextBox ID="HALLIDTextBox" runat="server" Text='<%# Bind("HALLID") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvHallEdit" runat="server"
                                    ControlToValidate="HALLIDTextBox" ErrorMessage="Hall ID is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvHallEdit" runat="server" ControlToValidate="HALLIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Show Date:</label>
                                <asp:TextBox ID="SHOWDATETextBox" runat="server"
                                    Text='<%# Bind("SHOWDATE", "{0:yyyy-MM-dd}") %>' CssClass="form-control"
                                    TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDateEdit" runat="server"
                                    ControlToValidate="SHOWDATETextBox" ErrorMessage="Date is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Show Time:</label>
                                <asp:TextBox ID="SHOWTIMETextBox" runat="server" Text='<%# Bind("SHOWTIME") %>'
                                    CssClass="form-control" placeholder="HH:MM AM/PM" />
                                <asp:RequiredFieldValidator ID="rfvTimeEdit" runat="server"
                                    ControlToValidate="SHOWTIMETextBox" ErrorMessage="Time is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update"
                                    Text="Update Schedule" CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CommandName="Cancel"
                                    Text="Cancel" CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <div class="form-group">
                                <label>Show ID:</label>
                                <asp:TextBox ID="SHOWIDTextBox" runat="server" Text='<%# Bind("SHOWID") %>'
                                    CssClass="form-control" placeholder="Unique numeric ID" />
                                <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="SHOWIDTextBox"
                                    ErrorMessage="ID is required" CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvId" runat="server" ControlToValidate="SHOWIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Movie ID:</label>
                                <asp:TextBox ID="MOVIEIDTextBox" runat="server" Text='<%# Bind("MOVIEID") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvMovie" runat="server"
                                    ControlToValidate="MOVIEIDTextBox" ErrorMessage="Movie ID is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvMovie" runat="server" ControlToValidate="MOVIEIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Hall ID:</label>
                                <asp:TextBox ID="HALLIDTextBox" runat="server" Text='<%# Bind("HALLID") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvHall" runat="server"
                                    ControlToValidate="HALLIDTextBox" ErrorMessage="Hall ID is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvHall" runat="server" ControlToValidate="HALLIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Show Date:</label>
                                <asp:TextBox ID="SHOWDATETextBox" runat="server" Text='<%# Bind("SHOWDATE") %>'
                                    CssClass="form-control" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                    ControlToValidate="SHOWDATETextBox" ErrorMessage="Date is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Show Time:</label>
                                <asp:TextBox ID="SHOWTIMETextBox" runat="server" Text='<%# Bind("SHOWTIME") %>'
                                    CssClass="form-control" placeholder="HH:MM AM/PM" />
                                <asp:RequiredFieldValidator ID="rfvTime" runat="server"
                                    ControlToValidate="SHOWTIMETextBox" ErrorMessage="Time is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert"
                                    Text="Add Showtime" CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CommandName="Cancel" Text="Reset"
                                    CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <div class="form-group">
                                <label>Selected Show:</label>
                                <div class="form-control" style="background:#f9f9f9; font-weight: 600;">Show ID: <%#
                                        Eval("SHOWID") %>
                                </div>
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit Schedule"
                                    CssClass="btn-link btn-add" CausesValidation="false" />
                                <asp:LinkButton ID="NewButton" runat="server" CommandName="New" Text="Add New"
                                    CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </ItemTemplate>
                    </asp:FormView>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>Active Showtimes</h3>
                </div>
                <div class="table-wrap">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="SHOWID" DataSourceID="SqlDataSource1"
                        CssClass="data-table" GridLines="None" PageSize="10"
                        OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="SHOWID" HeaderText="Show ID" ReadOnly="True"
                                SortExpression="SHOWID" />
                            <asp:BoundField DataField="MOVIEID" HeaderText="Movie ID" SortExpression="MOVIEID" />
                            <asp:BoundField DataField="HALLID" HeaderText="Hall ID" SortExpression="HALLID" />
                            <asp:BoundField DataField="SHOWDATE" HeaderText="Date" SortExpression="SHOWDATE"
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="SHOWTIME" HeaderText="Time" SortExpression="SHOWTIME" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CommandName="Select" Text="Select"
                                        CssClass="action-link" CausesValidation="false" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete"
                                        CssClass="action-link" OnClientClick="return confirm('Delete this showtime?');"
                                        CausesValidation="false" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>"
            ProviderName="<%$ ConnectionStrings:ConnectionString2.ProviderName %>"
            SelectCommand="SELECT * FROM SHOWS ORDER BY SHOWDATE DESC, SHOWTIME DESC"
            DeleteCommand="DELETE FROM SHOWS WHERE SHOWID = :SHOWID"
            InsertCommand="INSERT INTO SHOWS (SHOWID, MOVIEID, HALLID, SHOWDATE, SHOWTIME) VALUES (:SHOWID, :MOVIEID, :HALLID, :SHOWDATE, :SHOWTIME)"
            UpdateCommand="UPDATE SHOWS SET MOVIEID = :MOVIEID, HALLID = :HALLID, SHOWDATE = :SHOWDATE, SHOWTIME = :SHOWTIME WHERE SHOWID = :SHOWID"
            ConflictDetection="OverwriteChanges" OnInserted="DataSource_Error" OnUpdated="DataSource_Error"
            OnDeleted="DataSource_Error">
            <DeleteParameters>
                <asp:Parameter Name="SHOWID" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SHOWID" Type="Decimal" />
                <asp:Parameter Name="MOVIEID" Type="Decimal" />
                <asp:Parameter Name="HALLID" Type="Decimal" />
                <asp:Parameter Name="SHOWDATE" Type="DateTime" />
                <asp:Parameter Name="SHOWTIME" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MOVIEID" Type="Decimal" />
                <asp:Parameter Name="HALLID" Type="Decimal" />
                <asp:Parameter Name="SHOWDATE" Type="DateTime" />
                <asp:Parameter Name="SHOWTIME" Type="String" />
                <asp:Parameter Name="SHOWID" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:Content>
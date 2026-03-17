<%@ Page Title="Movie Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MovieDetails.aspx.cs" Inherits="DatabaseCw.MovieDetails" %>

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
            <h2>Movie Management</h2>
            <p>Manage film catalogs, durations and release schedules</p>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <div id="divMessage" runat="server" class="alert">
                <asp:Label ID="lblMessage" runat="server" />
            </div>
        </asp:Panel>

        <div class="form-grid">
            <div class="card">
                <div class="card-header">
                    <h3>Movie Entry</h3>
                </div>
                <div class="card-body">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="MOVIEID" DataSourceID="SqlDataSource1"
                        DefaultMode="Insert" Width="100%" AllowPaging="True">
                        <PagerSettings Visible="False" />
                        <EditItemTemplate>
                            <div class="form-group">
                                <label>Movie ID:</label>
                                <asp:Label ID="MOVIEIDLabel" runat="server" Text='<%# Eval("MOVIEID") %>'
                                    CssClass="form-control" style="background:#f9f9f9;" />
                            </div>
                            <div class="form-group">
                                <label>Title:</label>
                                <asp:TextBox ID="MOVIETITLETextBox" runat="server" Text='<%# Bind("MOVIETITLE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvTitleEdit" runat="server"
                                    ControlToValidate="MOVIETITLETextBox" ErrorMessage="Title is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Duration (mins):</label>
                                <asp:TextBox ID="MOVIEDURATIONTextBox" runat="server"
                                    Text='<%# Bind("MOVIEDURATION") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvDurEdit" runat="server"
                                    ControlToValidate="MOVIEDURATIONTextBox" ErrorMessage="Duration is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvDurEdit" runat="server"
                                    ControlToValidate="MOVIEDURATIONTextBox" Operator="DataTypeCheck" Type="Integer"
                                    ErrorMessage="Must be a number" CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Language:</label>
                                <asp:TextBox ID="MOVIELANGUAGETextBox" runat="server"
                                    Text='<%# Bind("MOVIELANGUAGE") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvLangEdit" runat="server"
                                    ControlToValidate="MOVIELANGUAGETextBox" ErrorMessage="Language is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Genre:</label>
                                <asp:TextBox ID="MOVIEGENRETextBox" runat="server" Text='<%# Bind("MOVIEGENRE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvGenreEdit" runat="server"
                                    ControlToValidate="MOVIEGENRETextBox" ErrorMessage="Genre is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Release Date:</label>
                                <asp:TextBox ID="MOVIERELEASEDATETextBox" runat="server"
                                    Text='<%# Bind("MOVIERELEASEDATE", "{0:yyyy-MM-dd}") %>' CssClass="form-control"
                                    TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDateEdit" runat="server"
                                    ControlToValidate="MOVIERELEASEDATETextBox" ErrorMessage="Release date is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update"
                                    Text="Update Movie" CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CommandName="Cancel"
                                    Text="Cancel" CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <div class="form-group">
                                <label>Movie ID:</label>
                                <asp:TextBox ID="MOVIEIDTextBox" runat="server" Text='<%# Bind("MOVIEID") %>'
                                    CssClass="form-control" placeholder="Unique numeric ID" />
                                <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="MOVIEIDTextBox"
                                    ErrorMessage="ID is required" CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvId" runat="server" ControlToValidate="MOVIEIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Title:</label>
                                <asp:TextBox ID="MOVIETITLETextBox" runat="server" Text='<%# Bind("MOVIETITLE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvTitle" runat="server"
                                    ControlToValidate="MOVIETITLETextBox" ErrorMessage="Title is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Duration (mins):</label>
                                <asp:TextBox ID="MOVIEDURATIONTextBox" runat="server"
                                    Text='<%# Bind("MOVIEDURATION") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvDur" runat="server"
                                    ControlToValidate="MOVIEDURATIONTextBox" ErrorMessage="Duration is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvDur" runat="server" ControlToValidate="MOVIEDURATIONTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Language:</label>
                                <asp:TextBox ID="MOVIELANGUAGETextBox" runat="server"
                                    Text='<%# Bind("MOVIELANGUAGE") %>' CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvLang" runat="server"
                                    ControlToValidate="MOVIELANGUAGETextBox" ErrorMessage="Language is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Genre:</label>
                                <asp:TextBox ID="MOVIEGENRETextBox" runat="server" Text='<%# Bind("MOVIEGENRE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvGenre" runat="server"
                                    ControlToValidate="MOVIEGENRETextBox" ErrorMessage="Genre is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Release Date:</label>
                                <asp:TextBox ID="MOVIERELEASEDATETextBox" runat="server"
                                    Text='<%# Bind("MOVIERELEASEDATE") %>' CssClass="form-control" TextMode="Date" />
                                <asp:RequiredFieldValidator ID="rfvDate" runat="server"
                                    ControlToValidate="MOVIERELEASEDATETextBox" ErrorMessage="Release date is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Add Movie"
                                    CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CommandName="Cancel" Text="Reset"
                                    CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <div class="form-group">
                                <label>Selected Movie:</label>
                                <div class="form-control" style="background:#f9f9f9; font-weight: 600;">
                                    <%# Eval("MOVIETITLE") %>
                                </div>
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit Details"
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
                    <h3>Movie Catalog</h3>
                </div>
                <div class="table-wrap">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="MOVIEID" DataSourceID="SqlDataSource1"
                        CssClass="data-table" GridLines="None" PageSize="10"
                        OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="MOVIEID" HeaderText="ID" ReadOnly="True"
                                SortExpression="MOVIEID" />
                            <asp:BoundField DataField="MOVIETITLE" HeaderText="Title" SortExpression="MOVIETITLE" />
                            <asp:BoundField DataField="MOVIEDURATION" HeaderText="Duration"
                                SortExpression="MOVIEDURATION" />
                            <asp:BoundField DataField="MOVIEGENRE" HeaderText="Genre" SortExpression="MOVIEGENRE" />
                            <asp:BoundField DataField="MOVIELANGUAGE" HeaderText="Language"
                                SortExpression="MOVIELANGUAGE" />
                            <asp:BoundField DataField="MOVIERELEASEDATE" HeaderText="Release"
                                SortExpression="MOVIERELEASEDATE" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CommandName="Select" Text="Select"
                                        CssClass="action-link" CausesValidation="false" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete"
                                        CssClass="action-link" OnClientClick="return confirm('Delete movie?');"
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
            SelectCommand="SELECT * FROM MOVIES ORDER BY MOVIEID DESC"
            DeleteCommand="DELETE FROM MOVIES WHERE MOVIEID = :MOVIEID"
            InsertCommand="INSERT INTO MOVIES (MOVIEID, MOVIETITLE, MOVIEDURATION, MOVIELANGUAGE, MOVIEGENRE, MOVIERELEASEDATE) VALUES (:MOVIEID, :MOVIETITLE, :MOVIEDURATION, :MOVIELANGUAGE, :MOVIEGENRE, :MOVIERELEASEDATE)"
            UpdateCommand="UPDATE MOVIES SET MOVIETITLE = :MOVIETITLE, MOVIEDURATION = :MOVIEDURATION, MOVIELANGUAGE = :MOVIELANGUAGE, MOVIEGENRE = :MOVIEGENRE, MOVIERELEASEDATE = :MOVIERELEASEDATE WHERE MOVIEID = :MOVIEID"
            ConflictDetection="OverwriteChanges" OnInserted="DataSource_Error" OnUpdated="DataSource_Error"
            OnDeleted="DataSource_Error">
            <DeleteParameters>
                <asp:Parameter Name="MOVIEID" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="MOVIEID" Type="Decimal" />
                <asp:Parameter Name="MOVIETITLE" Type="String" />
                <asp:Parameter Name="MOVIEDURATION" Type="Decimal" />
                <asp:Parameter Name="MOVIELANGUAGE" Type="String" />
                <asp:Parameter Name="MOVIEGENRE" Type="String" />
                <asp:Parameter Name="MOVIERELEASEDATE" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="MOVIETITLE" Type="String" />
                <asp:Parameter Name="MOVIEDURATION" Type="Decimal" />
                <asp:Parameter Name="MOVIELANGUAGE" Type="String" />
                <asp:Parameter Name="MOVIEGENRE" Type="String" />
                <asp:Parameter Name="MOVIERELEASEDATE" Type="DateTime" />
                <asp:Parameter Name="MOVIEID" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:Content>
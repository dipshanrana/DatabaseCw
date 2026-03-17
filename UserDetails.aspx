<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="UserDetails.aspx.cs" Inherits="DatabaseCw.UserDetails" %>

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
            <h2>User Management</h2>
            <p>Manage system access and user profiles</p>
        </div>

        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <div id="divMessage" runat="server" class="alert">
                <asp:Label ID="lblMessage" runat="server" />
            </div>
        </asp:Panel>

        <div class="form-grid">
            <div class="card">
                <div class="card-header">
                    <h3>Entry Form</h3>
                </div>
                <div class="card-body">
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="USERID" DataSourceID="SqlDataSource1"
                        DefaultMode="Insert" Width="100%" AllowPaging="True">
                        <PagerSettings Visible="False" />
                        <EditItemTemplate>
                            <div class="form-group">
                                <label>User ID:</label>
                                <asp:Label ID="USERIDLabel1" runat="server" Text='<%# Eval("USERID") %>'
                                    CssClass="form-control" style="background:#f9f9f9;" />
                            </div>
                            <div class="form-group">
                                <label>Full Name:</label>
                                <asp:TextBox ID="USERNAMETextBox" runat="server" Text='<%# Bind("USERNAME") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvNameEdit" runat="server"
                                    ControlToValidate="USERNAMETextBox" ErrorMessage="Name is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Email:</label>
                                <asp:TextBox ID="USEREMAILTextBox" runat="server" Text='<%# Bind("USEREMAIL") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvEmailEdit" runat="server"
                                    ControlToValidate="USEREMAILTextBox" ErrorMessage="Email is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revEmailEdit" runat="server"
                                    ControlToValidate="USEREMAILTextBox"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ErrorMessage="Invalid email format" CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Address:</label>
                                <asp:TextBox ID="USERADDRESSTextBox" runat="server" Text='<%# Bind("USERADDRESS") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvAddressEdit" runat="server"
                                    ControlToValidate="USERADDRESSTextBox" ErrorMessage="Address is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <asp:TextBox ID="USERPHONETextBox" runat="server" Text='<%# Bind("USERPHONE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvPhoneEdit" runat="server"
                                    ControlToValidate="USERPHONETextBox" ErrorMessage="Phone is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" Text="Update User"
                                    CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="UpdateCancelButton" runat="server" CommandName="Cancel"
                                    Text="Cancel" CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <div class="form-group">
                                <label>User ID:</label>
                                <asp:TextBox ID="USERIDTextBox" runat="server" Text='<%# Bind("USERID") %>'
                                    CssClass="form-control" placeholder="Unique numeric ID" />
                                <asp:RequiredFieldValidator ID="rfvId" runat="server" ControlToValidate="USERIDTextBox"
                                    ErrorMessage="ID is required" CssClass="validation-msg" Display="Dynamic" />
                                <asp:CompareValidator ID="cvId" runat="server" ControlToValidate="USERIDTextBox"
                                    Operator="DataTypeCheck" Type="Integer" ErrorMessage="Must be a number"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Full Name:</label>
                                <asp:TextBox ID="USERNAMETextBox" runat="server" Text='<%# Bind("USERNAME") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                    ControlToValidate="USERNAMETextBox" ErrorMessage="Name is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Email:</label>
                                <asp:TextBox ID="USEREMAILTextBox" runat="server" Text='<%# Bind("USEREMAIL") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                    ControlToValidate="USEREMAILTextBox" ErrorMessage="Email is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                    ControlToValidate="USEREMAILTextBox"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ErrorMessage="Invalid email format" CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Address:</label>
                                <asp:TextBox ID="USERADDRESSTextBox" runat="server" Text='<%# Bind("USERADDRESS") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                                    ControlToValidate="USERADDRESSTextBox" ErrorMessage="Address is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div class="form-group">
                                <label>Phone:</label>
                                <asp:TextBox ID="USERPHONETextBox" runat="server" Text='<%# Bind("USERPHONE") %>'
                                    CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server"
                                    ControlToValidate="USERPHONETextBox" ErrorMessage="Phone is required"
                                    CssClass="validation-msg" Display="Dynamic" />
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="InsertButton" runat="server" CommandName="Insert" Text="Add User"
                                    CssClass="btn-link btn-add" />
                                <asp:LinkButton ID="InsertCancelButton" runat="server" CommandName="Cancel" Text="Reset"
                                    CssClass="btn-link btn-secondary" CausesValidation="false" />
                            </div>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <div class="form-group">
                                <label>Selected User:</label>
                                <div class="form-control" style="background:#f9f9f9; font-weight: 600;">
                                    <%# Eval("USERNAME") %>
                                </div>
                            </div>
                            <div style="margin-top: 24px; border-top: 1px solid #eee; padding-top: 20px;">
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit Member"
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
                    <h3>Active Users</h3>
                </div>
                <div class="table-wrap">
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="USERID" DataSourceID="SqlDataSource1"
                        CssClass="data-table" GridLines="None" PageSize="10"
                        OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                        <Columns>
                            <asp:BoundField DataField="USERID" HeaderText="ID" ReadOnly="True"
                                SortExpression="USERID" />
                            <asp:BoundField DataField="USERNAME" HeaderText="Name" SortExpression="USERNAME" />
                            <asp:BoundField DataField="USEREMAIL" HeaderText="Email" SortExpression="USEREMAIL" />
                            <asp:BoundField DataField="USERADDRESS" HeaderText="Address" SortExpression="USERADDRESS" />
                            <asp:BoundField DataField="USERPHONE" HeaderText="Phone" SortExpression="USERPHONE" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CommandName="Select" Text="Select"
                                        CssClass="action-link" CausesValidation="false" />
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="Delete"
                                        CssClass="action-link" OnClientClick="return confirm('Delete this user?');"
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
            SelectCommand="SELECT * FROM USERS ORDER BY USERID DESC"
            DeleteCommand="DELETE FROM USERS WHERE USERID = :USERID"
            InsertCommand="INSERT INTO USERS (USERID, USERNAME, USERADDRESS, USEREMAIL, USERPHONE) VALUES (:USERID, :USERNAME, :USERADDRESS, :USEREMAIL, :USERPHONE)"
            UpdateCommand="UPDATE USERS SET USERNAME = :USERNAME, USERADDRESS = :USERADDRESS, USEREMAIL = :USEREMAIL, USERPHONE = :USERPHONE WHERE USERID = :USERID"
            ConflictDetection="OverwriteChanges" OnInserted="DataSource_Error" OnUpdated="DataSource_Error"
            OnDeleted="DataSource_Error">
            <DeleteParameters>
                <asp:Parameter Name="USERID" Type="Decimal" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="USERID" Type="Decimal" />
                <asp:Parameter Name="USERNAME" Type="String" />
                <asp:Parameter Name="USERADDRESS" Type="String" />
                <asp:Parameter Name="USEREMAIL" Type="String" />
                <asp:Parameter Name="USERPHONE" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="USERNAME" Type="String" />
                <asp:Parameter Name="USERADDRESS" Type="String" />
                <asp:Parameter Name="USEREMAIL" Type="String" />
                <asp:Parameter Name="USERPHONE" Type="String" />
                <asp:Parameter Name="USERID" Type="Decimal" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </asp:Content>
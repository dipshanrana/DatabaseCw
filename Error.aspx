<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="DatabaseCw.Error" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <title>System Error | Kumari Cinemas</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet" />
        <style>
            body {
                margin: 0;
                padding: 0;
                background-color: #0f0f0f;
                color: #ffffff;
                font-family: 'Inter', sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                text-align: center;
            }

            .error-container {
                max-width: 500px;
                padding: 40px;
                background: rgba(255, 255, 255, 0.03);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 12px;
                backdrop-filter: blur(10px);
            }

            .error-icon {
                font-size: 64px;
                color: #e74c3c;
                margin-bottom: 20px;
            }

            h1 {
                font-size: 28px;
                margin-bottom: 16px;
                font-weight: 600;
            }

            p {
                color: #888;
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .btn-home {
                display: inline-block;
                background: #c0392b;
                color: white;
                padding: 12px 30px;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                transition: background 0.3s ease;
            }

            .btn-home:hover {
                background: #e74c3c;
            }

            .technical-info {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                font-size: 12px;
                color: #555;
                text-align: left;
            }
        </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="error-container">
                <div class="error-icon">⚠</div>
                <h1>Something Went Wrong</h1>
                <p>We're experiencing technical difficulties connecting to our services. Our team has been notified and
                    we're working to fix it.</p>
                <a href="Default.aspx" class="btn-home">Return to Dashboard</a>

                <asp:Panel ID="pnlDebug" runat="server" Visible="false" CssClass="technical-info">
                    <strong>Error Details:</strong><br />
                    <asp:Label ID="lblError" runat="server" />
                </asp:Panel>
            </div>
        </form>
    </body>

    </html>
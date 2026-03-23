<%@ Page Title="Contact Support" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Contact.aspx.cs" Inherits="DatabaseCw.Contact" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <style>
            .contact-wrap {
                max-width: 600px;
                margin: 40px auto;
            }

            .contact-card {
                background: #fff;
                padding: 40px;
                border-radius: 4px;
                border: 1px solid #ddd;
                border-top: 4px solid #c0392b;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
            }

            .contact-card h2 {
                margin: 0 0 10px;
                font-size: 1.5rem;
                font-weight: 700;
                color: #111;
            }

            .contact-card p {
                color: #666;
                margin-bottom: 30px;
                font-size: 0.95rem;
            }

            .info-item {
                margin-bottom: 24px;
            }

            .info-item label {
                display: block;
                font-size: 0.75rem;
                text-transform: uppercase;
                color: #aaa;
                font-weight: 700;
                margin-bottom: 4px;
                letter-spacing: 0.5px;
            }

            .info-item .val {
                font-size: 1.05rem;
                color: #333;
                font-weight: 500;
            }

            .info-item a {
                color: #c0392b;
                text-decoration: none;
                border-bottom: 1px dashed #c0392b;
            }

            .info-item a:hover {
                color: #a93226;
                border-bottom-style: solid;
            }
        </style>

        <div class="contact-wrap">
            <div class="contact-card">
                <h2>Get in Touch</h2>
                <p>For administrative support or technical inquiries regarding the KumariCinemas Management System.</p>

                <div class="info-item">
                    <label>Corporate Office</label>
                    <div class="val">Bijayapur, Pokhara<br />Gandaki Province, Nepal</div>
                </div>

                <div class="info-item">
                    <label>Technical Support</label>
                    <div class="val"><a href="mailto:support@kumaricinemas.com">support@kumaricinemas.com</a></div>
                </div>

                <div class="info-item">
                    <label>Operations Helpdesk</label>
                    <div class="val">98101010101 (Sun-Fri, 9AM-5PM)</div>
                </div>
            </div>
        </div>
    </asp:Content>
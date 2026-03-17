<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs"
    Inherits="DatabaseCw.About" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <style>
            .about-wrap {
                max-width: 800px;
                margin: 0 auto;
                padding: 40px 20px;
                text-align: center;
            }

            .about-wrap h2 {
                font-size: 2rem;
                color: #111;
                margin-bottom: 20px;
                font-weight: 800;
            }

            .about-wrap h2 span {
                color: #c0392b;
            }

            .about-wrap p {
                font-size: 1.1rem;
                color: #666;
                line-height: 1.8;
                margin-bottom: 30px;
            }

            .divider {
                width: 60px;
                height: 3px;
                background: #c0392b;
                margin: 0 auto 30px;
            }
        </style>

        <div class="about-wrap">
            <h2>About <span>KumariCinemas</span></h2>
            <div class="divider"></div>
            <p>
                KumariCinemas Management System is a comprehensive platform designed to streamline cinema operations.
                From managing multi-city theatre halls to tracking real-time seat occupancy and movie schedules,
                we provide the tools necessary for modern cinema administration in Nepal.
            </p>
            <p>
                Our system focuses on efficiency, reliability, and ease of use, ensuring that theatre managers
                can focus on delivering the best movie-going experience to their customers.
            </p>
        </div>
    </asp:Content>
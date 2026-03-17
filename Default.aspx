<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="DatabaseCw._Default" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <style>
            .dash-hero {
                background: #1a1a1a;
                color: #fff;
                padding: 40px 40px 36px;
                border-radius: 4px;
                margin-bottom: 32px;
            }

            .dash-hero h1 {
                margin: 0 0 6px;
                font-size: 1.9rem;
                font-weight: 700;
                letter-spacing: -0.3px;
            }

            .dash-hero h1 span {
                color: #c0392b;
            }

            .dash-hero p {
                margin: 0;
                color: #999;
                font-size: 0.92rem;
            }

            .section-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: #999;
                margin: 32px 0 14px;
                padding-bottom: 8px;
                border-bottom: 1px solid #ddd;
            }

            .card-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 14px;
                margin-bottom: 8px;
            }

            .dash-card {
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 4px;
                padding: 22px 20px;
                text-decoration: none;
                color: #222;
                display: block;
                transition: border-color 0.15s, box-shadow 0.15s;
                border-left: 3px solid #ddd;
            }

            .dash-card:hover {
                border-left-color: #c0392b;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                text-decoration: none;
                color: #222;
            }

            .dash-card .card-title {
                font-size: 0.9rem;
                font-weight: 600;
                margin-bottom: 5px;
                color: #111;
            }

            .dash-card .card-desc {
                font-size: 0.78rem;
                color: #888;
                line-height: 1.5;
            }

            .dash-card.report {
                border-left-color: #c0392b;
                background: #fdfafa;
            }

            .dash-card.report:hover {
                background: #fff5f5;
            }

            .dash-card.report .card-title {
                color: #a93226;
            }
        </style>

        <div class="dash-hero">
            <h1>Kumari<span>Cinemas</span> Management</h1>
            <p>Centralized cinema operations system &mdash; Manage theatres, movies, bookings and tickets</p>
        </div>

        <div class="section-label">Basic Management Forms</div>
        <div class="card-grid">
            <a href="~/UserDetails.aspx" runat="server" class="dash-card">
                <div class="card-title">Users</div>
                <div class="card-desc">Add, edit and delete registered user accounts</div>
            </a>
            <a href="~/TheatreCityHall.aspx" runat="server" class="dash-card">
                <div class="card-title">Theatre City Hall</div>
                <div class="card-desc">Manage theatres and halls across Nepal</div>
            </a>
            <a href="~/ShowTimeDetails.aspx" runat="server" class="dash-card">
                <div class="card-title">Showtimes</div>
                <div class="card-desc">Schedule and manage movie showtimes per hall</div>
            </a>
            <a href="~/MovieDetails.aspx" runat="server" class="dash-card">
                <div class="card-title">Movies</div>
                <div class="card-desc">Add and manage movies in the system</div>
            </a>
            <a href="~/Ticket.aspx" runat="server" class="dash-card">
                <div class="card-title">Tickets</div>
                <div class="card-desc">View and manage individual ticket records</div>
            </a>
        </div>

        <div class="section-label">Complex Report Forms</div>
        <div class="card-grid">
            <a href="~/UserTicket.aspx" runat="server" class="dash-card report">
                <div class="card-title">User Ticket Report</div>
                <div class="card-desc">View tickets a user bought in the last 6 months</div>
            </a>
            <a href="~/TheatreCityHallMovie.aspx" runat="server" class="dash-card report">
                <div class="card-title">Theatre Hall Movies</div>
                <div class="card-desc">Movies and showtimes for any selected hall</div>
            </a>
            <a href="~/MovieTheatreOccupancy.aspx" runat="server" class="dash-card report">
                <div class="card-title">Movie Occupancy (Top 3)</div>
                <div class="card-desc">Top 3 halls by seat occupancy for any movie</div>
            </a>
        </div>

    </asp:Content>
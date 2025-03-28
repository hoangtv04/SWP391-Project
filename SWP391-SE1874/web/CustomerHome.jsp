<%-- 
    Document   : CustomerHome
    Created on : Mar 1, 2025, 11:18:29 PM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Movie"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show Movies</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
        background-color: #ffffff;
            }
            .container {
                margin-top: 20px;
            }
            .row {
                margin-bottom: 20px;
            }
            .movie-item {
                margin-bottom: 20px;
                border: 2px solid #fff;
                border-radius: 5px;
                padding: 10px;
                background-color: #8b8585;
                transition: transform 0.3s ease;
                position: relative;
            }
            .movie-item:hover {
                transform: scale(1.05);
            }
            .movie-item h2 {
                font-size: 20px;
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                color: #333;
                transition: text-decoration 0.3s ease;
            }
            .movie-item h2:hover {
                text-decoration: underline;
            }
            .movie-item p {
                margin: 5px 0;
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                color: #666;
            }
            .movie-item a {
                display: inline-block;
                margin-top: 10px;
                padding: 10px 15px;
                background: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
            }
            .movie-item a:hover {
                background: #0056b3;
            }
            .movie-item img {
                width: 100%;
                height: 500px;
                object-fit: cover;
                border-radius: 5px;
                transition: transform 0.3s ease;
            }
            .carousel-item img {
                height: 550px;
            }
            .carousel-indicators li {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                background-color: #ffff;
            }
            .carousel-indicators .active {
                background-color: #ffff;
            }
            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-size: 100%, 100%;
                width: 50px;
                height: 50px;
            }
            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
            }
            .navbar-nav {
                margin-right: 40%;
                display: flex;
                justify-content: center;
            }
            .nav-item {
                padding: 0 15px;
            }
            .nav-link {
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                font-size: 18px;
                color: blue;
                transition: color 0.3s ease, text-decoration 0.3s ease, transform 0.3s ease;
            }
            .nav-link:hover {
                color: #007bff;
                text-decoration: underline;
                transform: scale(1.1);
            }
            .nav-link[href="movie"],
            .nav-link[href="contact"],
            .nav-link[href="members"] {
                font-weight: bold;
            }
            .navbar-nav .nav-link {
      color: rgb(254, 254, 254) !important;
            }
            .footer {
                background-color: #eaeaedc6;
                padding: 10px 0; /* Further reduced padding */
                text-align: center;
                border-top: 1px solid #fafafa;
                margin-top: 10px; /* Reduced margin at the top */
                font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
                font-size: 12px; /* Further reduced font size */
                color: #0f0e0e;
            }

            .footer p {
     margin: 3px 0; /* Further reduced margin */
            }
            .footer h2 {
                font-size: 14px; /* Further reduced heading size */
                margin-bottom: 5px; /* Further reduced bottom margin */
            }
            .see-more-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                color: #fff;
                display: flex;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.3s ease;
                border-radius: 5px;
            }
            .movie-item:hover .see-more-overlay {
                opacity: 1;
            }
            .customer-img {
                width: 70px; /* Tăng kích thước ô tròn */
                height: 70px; /* Tăng kích thước ô tròn */
                border-radius: 50%;
                object-fit: cover;
                border: 2px solid #007bff;
                cursor: pointer;
            }

            .dropdown-menu {
                animation: slideDown 0.3s ease-in-out;
            }

            @keyframes slideDown {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
            .navbar {
background-color: #ec3333; 
                color: #fff;
            }
            .footer h2 {
                font-size: 14px; /* Heading size */
                margin-bottom: 5px; /* Bottom margin */
                font-weight: bold; /* Make the text bold */
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <!-- Move search bar to the left -->
                <form class="form-inline mr-auto" action="searchmovie" method="get">
                    <input class="form-control mr-sm-2" type="search" name="query" placeholder="Search movies" aria-label="Search">
                    <button class="btn btn-dark my-2 my-sm-0" type="submit">Search</button>
                </form>             
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="movie">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="contact">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="members">Members</a>
                    </li>
                </ul>
                <%
                    model.Customer customer = (model.Customer) session.getAttribute("customer");
                %>
                <div class="dropdown ml-3">
                    <img src="image customer/customer.jpg" alt="Customer" class="customer-img dropdown-toggle" id="customerDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <div class="dropdown-menu dropdown-menu-right p-3" aria-labelledby="customerDropdown" style="width: 250px;">
                        <h5 class="text-center">Profile</h5>
                        <a href="viewProfile.jsp" class="btn btn-primary btn-block">View Profile</a>
                        <hr>
                        <form action="purchaseHistory.jsp" method="get">
                            <button class="btn btn-primary btn-block" type="submit">Ticket History</button>
                        </form>
                        <hr>
                        <form action="Login.jsp" method="post">
                            <button class="btn btn-danger btn-block" type="submit">Logout</button>
                        </form>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Banner Section -->
        <div id="bannerCarousel" class="carousel slide" data-ride="carousel" data-interval="2000">
            <!-- Indicators -->
            <ol class="carousel-indicators">
                <li data-target="#bannerCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#bannerCarousel" data-slide-to="1"></li>
                <li data-target="#bannerCarousel" data-slide-to="2"></li>
                <li data-target="#bannerCarousel" data-slide-to="3"></li>
                <li data-target="#bannerCarousel" data-slide-to="4"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="images banner/banner1.jpg" class="d-block w-100" alt="Banner 1">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner2.jpg" class="d-block w-100" alt="Banner 2">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner3.jpg" class="d-block w-100" alt="Banner 3">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner4.jpg" class="d-block w-100" alt="Banner 4">
                </div>
                <div class="carousel-item">
                    <img src="images banner/banner5.jpg" class="d-block w-100" alt="Banner 5">
                </div>
            </div>
            <a class="carousel-control-prev" href="#bannerCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#bannerCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <div class="container">
            <%
                List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                if (movies != null && !movies.isEmpty()) {
                    movies.sort((m1, m2) -> Integer.compare(m1.getMovieID(), m2.getMovieID()));

                    int index = 1;
                    for (int i = 0; i < movies.size(); i++) {
                        if (i % 3 == 0) {
            %>
            <div class="row">
                <%
                            }
                %>
                <div class="col-md-4 movie-item">
                    <div class="card h-100 d-flex flex-column">
                        <img src="images poster/phim<%= movies.get(i).getMovieID() %>.jpg" class="card-img-top" alt="<%= movies.get(i).getTitle() %>">
                        <div class="see-more-overlay">
                            <a href="movieDetails?movieId=<%= movies.get(i).getMovieID() %>" class="btn btn-primary">See More</a>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <h2 class="card-title text-center"><%= movies.get(i).getTitle() %></h2>
                            <p class="card-text text-center"><strong>Release Date:</strong> <%= movies.get(i).getReleaseDate() %></p>
                        </div>
                    </div>
                </div>
                <%
                            index++;
                            if ((i + 1) % 3 == 0 || i == movies.size() - 1) {
                %>
            </div>
            <%
                        }
                    }
                } else {
            %>
            <div class="row">
                <p class="col-12">No movies available.</p>
            </div>
            <%
                }
            %>
        </div>

        <!-- Footer Section -->
        <footer class="footer">
<div class="container">
                <div class="row">
                    <!-- Contact Information -->
                    <div class="col-md-6">
                        <h2>Liên Hệ</h2>
                        <p>
                        CÔNG TY CỔ PHẦN XYZ TECHNOLOGIES<br><br>
                        Giấy chứng nhận ĐKKD số: 0101234567 - Đăng ký lần đầu ngày 01/01/2015 tại Sở Kế hoạch và Đầu
                        tư Thành phố Hồ Chí Minh<br><br>
                        Địa chỉ trụ sở: Tầng 2, số 123, đường Nguyễn Trãi, phường 5, quận 3, thành phố Hồ Chí
                        Minh<br><br>
                        Hotline: 1800 123 456 / 0901 234 567<br><br>
                        Email: contact@xyztechnologies.vn
                    </p>
</div>
                    <!-- Business Inquiries -->
                    <div class="col-md-6">
                        <h2>HỢP TÁC KINH DOANH:</h2>
                    <p>
                        Hotline: 1800 987 654<br><br>
                        Email: partnership@xyzgroup.vn
                    </p>
                    </div>
                    <!-- Newsletter Subscription -->
                </div>
                <div class="business-contact">
                    <h2>HỢP TÁC KINH DOANH:</h2>
                    <p>
                        Hotline: 1800 987 654<br><br>
                        Email: partnership@xyzgroup.vn
                    </p>
                </div>
            </div>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>


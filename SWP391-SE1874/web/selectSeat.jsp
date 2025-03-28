<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Seat" %>

<%
    // Retrieve the list of seats and other attributes from the request
    List<Seat> seats = (List<Seat>) request.getAttribute("seats");
    String movieName = (String) request.getAttribute("movieName");
    String cinemaName = (String) request.getAttribute("cinemaName");
    String screenName = (String) request.getAttribute("screenName");
    String startTime = (String) request.getAttribute("startTime");
    String endTime = (String) request.getAttribute("endTime");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/selectSeat.css">       
        <title>Select Seat</title>
        <script>
            window.addEventListener('scroll', function () {
                var nav = document.getElementById('main-nav');
                if (window.scrollY > 0) {
                    nav.classList.add('sticky');
                } else {
                    nav.classList.remove('sticky');
                }
            });
            document.addEventListener('DOMContentLoaded', function () {
                const checkboxes = document.querySelectorAll('.seat input[type="checkbox"]');
                checkboxes.forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        if (this.checked) {
                            this.parentElement.classList.add('selected-seat');
                        } else {
                            this.parentElement.classList.remove('selected-seat');
                        }
                    });
                });
               
                document.querySelector('.confirm-booking-button').addEventListener('click', function (event) {
                    event.preventDefault();

                    const selectedSeats = document.querySelectorAll('.seat input:checked');
                    if (selectedSeats.length === 0) {
                        alert('Bạn phải chọn ít nhất một ghế trước khi tiếp tục!');
                        return;
                    }
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = 'confirmBooking';

                    const movieId = document.createElement('input');
                    movieId.type = 'hidden';
                    movieId.name = 'movieId';
                    movieId.value = '<%= request.getParameter("movieId") %>';
                    form.appendChild(movieId);

                    const movieName = document.createElement('input');
                    movieName.type = 'hidden';
                    movieName.name = 'movieName';
                    movieName.value = '<%= movieName %>';
                    form.appendChild(movieName);

                    const cinemaId = document.createElement('input');
                    cinemaId.type = 'hidden';
                    cinemaId.name = 'cinemaId';
                    cinemaId.value = '<%= request.getParameter("cinemaId") %>';
                    form.appendChild(cinemaId);

                    const cinemaName = document.createElement('input');
                    cinemaName.type = 'hidden';
                    cinemaName.name = 'cinemaName';
                    cinemaName.value = '<%= cinemaName %>';
                    form.appendChild(cinemaName);

                    const screenId = document.createElement('input');
                    screenId.type = 'hidden';
                    screenId.name = 'screenId';
                    screenId.value = '<%= request.getParameter("screenId") %>';
                    form.appendChild(screenId);

                    const screenName = document.createElement('input');
                    screenName.type = 'hidden';
                    screenName.name = 'screenName';
                    screenName.value = '<%= screenName %>';
                    form.appendChild(screenName);

                    const startTime = document.createElement('input');
                    startTime.type = 'hidden';
                    startTime.name = 'startTime';
                    startTime.value = '<%= startTime %>';
                    form.appendChild(startTime);

                    const endTime = document.createElement('input');
                    endTime.type = 'hidden';
                    endTime.name = 'endTime';
                    endTime.value = '<%= endTime %>';
                    form.appendChild(endTime);

                    document.querySelectorAll('.seat input:checked').forEach(function (seat) {
                        const seatId = document.createElement('input');
                        seatId.type = 'hidden';
                        seatId.name = 'seatIds';
                        seatId.value = seat.value;
                        form.appendChild(seatId);
                    });

                    document.body.appendChild(form);
                    form.submit();
                });
            });
        </script>
        <script>
            document.querySelectorAll('.seat-selection').forEach(function (seatElement) {
                seatElement.addEventListener('change', function () {
                    var selectedSeatId = this.value;
                    if (selectedSeatId) {
                        // Send the selected seatId to the server to store it in the session
                        var xhr = new XMLHttpRequest();
                        xhr.open('POST', 'storeSeatInSession', true);
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.send('seatId=' + selectedSeatId);
                    }
                });
            });
        </script>
    </head>
    <body>
        <header class="header">
            <h1>Select Seat</h1>
        </header>

        <nav id="main-nav">

            <a href="movie">Home</a>
            <a href="contact">Contact</a>
        </nav>

        <div class="container">
            <div class="movie-info">
                <h2>Movie: <%= movieName %></h2>
                <p><strong>Cinema:</strong> <%= cinemaName %></p>
                <p><strong>Screen:</strong> <%= screenName %></p>
                <p><strong>Start Time:</strong> <%= startTime %></p>
            </div>

            <form action="confirmBooking" method="post">
                <div class="seats-container">
                    <%
                        if (seats != null) {
                            char currentRow = ' ';
                            for (Seat seat : seats) {
                                if (seat.getSeatNumber().charAt(0) != currentRow) {
                                    if (currentRow != ' ') {
                    %>
                </div>
                <%
                                }
                                currentRow = seat.getSeatNumber().charAt(0);
                %>
                <div class="seat-row">
                    <%
                                }
                    %>
                    <div class="seat <%= seat.getSeatType().equalsIgnoreCase("VIP") ? "vip-seat" : "regular-seat" %>">
                        <input type="checkbox" id="seat<%= seat.getSeatID() %>" name="seatIds" value="<%= seat.getSeatID() %>" class="seat-selection">
                        <label for="seat<%= seat.getSeatID() %>"><%= seat.getSeatNumber() %></label>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="seat-note">
                    <div class="seat regular-seat"></div> Standard
                    <div class="seat vip-seat"></div> VIP
                </div>
                <div class="confirm-booking-button-container">
                    <button class="back-button" onclick="window.history.back();
                            return false;">Back</button>
                    <button type="submit" class="confirm-booking-button">Confirm Booking</button>
                </div>
        </div>
    </form>
</div>   

    <footer class="footer">
        <div class="contact-container">
            <div class="contact-info">
                <h2>LIÊN HỆ</h2>
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
            <div class="business-contact">
                <h2>HỢP TÁC KINH DOANH:</h2>
                <p>
                    Hotline: 1800 987 654<br><br>
                    Email: partnership@xyzgroup.vn
                </p>
            </div>
        </div>
    </footer>
</body>
</html>


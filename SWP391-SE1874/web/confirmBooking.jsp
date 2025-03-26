<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Seat" %>
<%@ page import="model.Voucher" %>
<%@ page import="dal.VoucherDAO" %>

<%
    List<Seat> selectedSeats = (List<Seat>) request.getAttribute("selectedSeats");
    String movieName = (String) request.getAttribute("movieName");
    String cinemaName = (String) request.getAttribute("cinemaName");
    String screenName = (String) request.getAttribute("screenName");

    double totalPrice = 0;
    if (selectedSeats != null) {
        for (Seat seat : selectedSeats) {
            totalPrice += seat.getPrice();
        }
    }

    VoucherDAO voucherDAO = new VoucherDAO();
    List<Voucher> vouchers = voucherDAO.getAllVouchers();

    // Generate QR code URL (for demonstration purposes, using a placeholder URL)
    String qrCodeUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=Total%20Price:%20" + totalPrice;
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/confirmBooking.css">
        <title>Confirm Booking</title>
        <script>
            window.addEventListener('scroll', function () {
                var nav = document.getElementById('main-nav');
                if (window.scrollY > 0) {
                    nav.classList.add('sticky');
                } else {
                    nav.classList.remove('sticky');
                }
            });
        </script>
        <style>
            #voucherForm label {
                font-size: 1.2em;
                font-weight: bold;
                color: #333;
            }
            #voucherForm select {
                font-size: 0.9em;
                padding: 8px;
            }
            #voucherForm button {
                font-size: 0.9em;
                padding: 8px;
                border: 2px solid #333;
                font-weight: bold;
                color: #333;
                transition: background-color 0.3s, color 0.3s;
            }
            #voucherForm button:hover {
                background-color: #333; 
                color: #fff;
            }
        </style>
    </head>
    <body>
        <header class="header">
            <h1>Confirm Booking</h1>
        </header>

        <nav id="main-nav">
            <a href="movie">Home</a>
            <a href="contact.jsp">Contact</a>
        </nav>

        <div class="container">
            <div class="content">
                <div class="qr-code">
                    <h3>Scan to Pay</h3>
                    <img src="<%= qrCodeUrl %>" alt="QR Code for Payment">
                </div>

                <h2>Movie: <%= movieName %></h2>
                <p><strong>Cinema:</strong> <%= cinemaName %></p>
                <p><strong>Showtime:</strong> <%= request.getAttribute("startTime") %> - <%= request.getAttribute("endTime") %></p>
                <p><strong>Seats:</strong>
                    <%
                        if (selectedSeats != null) {
                            for (Seat seat : selectedSeats) {
                    %>
                <p><%= seat.getSeatNumber() %> : <%= seat.getSeatType() %> : $<%= seat.getPrice() %></p>
                <%
                        }
                    }
                %>

                <p><strong>Total Price:</strong> $<span id="totalPrice"><%= totalPrice %></span></p>

                <form id="voucherForm" action="applyvoucher" method="post" onsubmit="applyVoucher(event)">
                    <label for="voucherCode">Select Voucher:</label>
                    <select name="voucherCode" id="voucherCode" onchange="updateDiscountedPrice()">
                        <%
                            for (Voucher voucher : vouchers) {
                        %>
                        <option value="<%= voucher.getDiscountAmount() %>"><%= voucher.getCode() %> - $<%= voucher.getDiscountAmount() %></option>
                        <%
                            }
                        %>
                    </select>
                    <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
                    <input type="hidden" name="discountedPrice" id="hiddenDiscountedPrice" value="<%= totalPrice %>">
                    <input type="hidden" name="discountAmount" id="hiddenDiscountAmount" value="0.00">
                    <input type="hidden" name="customerId" value="<%= request.getSession().getAttribute("customerId") %>">
                    <input type="hidden" name="showtimeId" value="<%= request.getSession().getAttribute("showtimeId") %>">
                    <input type="hidden" name="seatId" value="<%= request.getSession().getAttribute("seatId") %>">
                    <input type="hidden" name="screenName" value="<%= request.getSession().getAttribute("screenName") %>">
                    <input type="hidden" name="screenId" value="<%= request.getSession().getAttribute("screenId") %>">
                    <input type="hidden" name="voucherId" value="<%= request.getSession().getAttribute("voucherId") %>">
                    <input type="hidden" name="movieId" value="<%= request.getSession().getAttribute("movieId") %>">
                    <button type="submit">Apply Voucher</button>
                </form>

                <p><strong>Discount Amount:</strong> $<span id="discountAmount">0.00</span></p>
                <p><strong>Total Price:</strong> $<span id="discountedPrice"><%= totalPrice %></span></p>
                <div class="confirm-booking-button-container">
                    <button class="back-button" onclick="window.history.back(); return false;">Back</button>
                    <button type="submit" class="confirm-booking-button">Done</button>
                </div>
            </div>
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

        <script>
            document.querySelector('.confirm-booking-button').addEventListener('click', function (event) {
                event.preventDefault();
                alert('Your booking has been successfully confirmed!');
                window.location.href = 'movie';
            });
        </script>
        <script>
            // Hàm quay lại trang trước đó
            function goBack() {
                window.history.back();
            }
        </script>
        <script>
            function updateDiscountedPrice() {
                var totalPrice = parseFloat(document.getElementById('totalPrice').innerText);
                var discountAmount = parseFloat(document.getElementById('voucherCode').value);
                var discountedPrice = totalPrice - discountAmount;
                document.getElementById('discountedPrice').innerText = discountedPrice.toFixed(2);
            }
        </script>
        <script>
            function applyVoucher(event) {
                event.preventDefault();

                // Get the original total price and the selected voucher discount amount
                var totalPrice = parseFloat(document.getElementById('totalPrice').innerText);
                var discountAmount = parseFloat(document.getElementById('voucherCode').value);

                // Calculate the discounted price
                var discountedPrice = totalPrice - discountAmount;

                // Update the Discount Amount and Discounted Price fields
                document.getElementById('discountAmount').innerText = discountAmount.toFixed(2);
                document.getElementById('discountedPrice').innerText = discountedPrice.toFixed(2);

                // Update hidden fields for form submission
                document.getElementById('hiddenDiscountedPrice').value = discountedPrice.toFixed(2);
                document.getElementById('hiddenDiscountAmount').value = discountAmount.toFixed(2);
            }
        </script>
        <script>
            document.querySelector('.confirm-booking-button').addEventListener('click', function (event) {
                event.preventDefault();
                document.getElementById('bookingForm').submit();
            });
        </script>

    </body>
</html>
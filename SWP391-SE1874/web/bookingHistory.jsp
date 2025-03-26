<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Booking" %>

<%
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Booking History</title>
        <link rel="stylesheet" href="css/confirmBooking.css">
    </head>
    <body>
        <header class="header">
            <h1>Booking History</h1>
        </header>
        <div class="container">
            <h2>Your Booking History</h2>
            <table border="1" cellpadding="10" cellspacing="0">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Movie ID</th>
                        <th>Cinema ID</th>
                        <th>Screen ID</th>
                        <th>Seat ID</th>
                        <th>Showtime ID</th>
                        <th>Booking Date</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (bookings != null && !bookings.isEmpty()) {
                            for (Booking booking : bookings) {
                    %>
                    <tr>
                        <td><%= booking.getBookingID() %></td>
                        <td><%= booking.getMovieID() %></td>
                        <td><%= booking.getCinemaID() %></td>
                        <td><%= booking.getScreenID() %></td>
                        <td><%= booking.getSeatID() %></td>
                        <td><%= booking.getShowtimeID() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td>$<%= booking.getTotalPrice() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="8">No bookings found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>

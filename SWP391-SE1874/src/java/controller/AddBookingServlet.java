package controller;

import dal.BookingDAO;
import model.Booking;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AddBookingServlet", urlPatterns = {"/addBooking"})
public class AddBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            int customerID = Integer.parseInt(request.getParameter("customerID"));
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            int cinemaID = Integer.parseInt(request.getParameter("cinemaID"));
            int screenID = Integer.parseInt(request.getParameter("screenID"));
            int seatID = Integer.parseInt(request.getParameter("seatID"));
            int showtimeID = Integer.parseInt(request.getParameter("showtimeID"));
            double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));


            SeatDAO seatDAO = new SeatDAO();
            List<Seat> selectedSeats = new ArrayList<>();
            if (seatIds != null) {
                selectedSeats = seatDAO.getSeatsByIds(seatIds);
            }

            // Gọi BookingDAO để thêm dữ liệu vào database
            BookingDAO bookingDAO = new BookingDAO();
            for (Seat seat : selectedSeats) {
                Booking booking = new Booking();
                booking.setCustomerID(customerId);
                booking.setMovieID(seat.getMovieID()); // Giả sử Seat có thông tin MovieID
                booking.setCinemaID(seat.getCinemaID()); // Giả sử Seat có thông tin CinemaID
                booking.setScreenID(seat.getScreenID());
                booking.setSeatID(seat.getSeatID());
                booking.setShowtimeID(seat.getShowtimeID()); // Giả sử Seat có thông tin ShowtimeID
                booking.setTotalPrice(totalPrice); // Chia đều giá cho từng ghế

                bookingDAO.insertBooking(booking);
            }

            // Chuyển hướng về trang xác nhận hoặc hiển thị thông báo thành công
            response.sendRedirect("confirmBooking.jsp?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("confirmBooking.jsp?success=false");
        }
    }
}
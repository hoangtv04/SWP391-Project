/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.SeatDAO;
import dal.BookingDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Seat;
import model.Booking;
import model.Customer;


@WebServlet(name="ConfirmBookingServlet", urlPatterns={"/confirmBooking"})
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Debug logs to verify received parameters
            System.out.println("Action: " + request.getParameter("action"));
            System.out.println("Movie Name: " + request.getParameter("movieName"));
            System.out.println("Cinema Name: " + request.getParameter("cinemaName"));
            System.out.println("Screen Name: " + request.getParameter("screenName"));
            System.out.println("Start Time: " + request.getParameter("startTime"));
            System.out.println("End Time: " + request.getParameter("endTime"));
            System.out.println("Voucher ID: " + request.getParameter("voucherId"));
            System.out.println("Total Price: " + request.getParameter("totalPrice"));
            System.out.println("Seat IDs: " + String.join(", ", request.getParameterValues("seatIds")));

            // Check if the action is "done"
            String action = request.getParameter("action");
            

            String movieName = request.getParameter("movieName");
            String cinemaName = request.getParameter("cinemaName");
            String screenName = request.getParameter("screenName");

            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            
            // Retrieve customerId from the session
            Customer customer = (Customer) request.getSession().getAttribute("customer");
            if (customer == null) {
                response.sendRedirect("Login.jsp"); // Redirect to login if customer is not logged in
                return;
            }
            int customerId = customer.getCustomerID();

            // Retrieve showtimeId from the request or session
            String showtimeIdParam = request.getParameter("showtimeId");
            int showtimeId;
            if (showtimeIdParam != null) {
                showtimeId = Integer.parseInt(showtimeIdParam);
            } else {
                Object showtimeIdSession = request.getSession().getAttribute("showtimeId");
                if (showtimeIdSession == null) {
                    throw new IllegalArgumentException("Showtime ID is missing");
                }
                showtimeId = (int) showtimeIdSession;
            }

            // Retrieve seatIds from the request or session
            List<Integer> seatIds = new ArrayList<>();
            String[] seatIdsParam = request.getParameterValues("seatIds");
            if (seatIdsParam != null) {
                for (String seatId : seatIdsParam) {
                    seatIds.add(Integer.parseInt(seatId));
                }
            } else {
                Object seatIdsSession = request.getSession().getAttribute("seatIds");
                if (seatIdsSession == null) {
                    throw new IllegalArgumentException("Seat ID is missing");
                }
                seatIds = (List<Integer>) seatIdsSession;
            }

            // Convert List<Integer> to String[]
            String[] seatIdsArray = seatIds.stream().map(String::valueOf).toArray(String[]::new);

            // Retrieve seats using seatDAO
            SeatDAO seatDAO = new SeatDAO();
            List<Seat> selectedSeats = seatDAO.getSeatsByIds(seatIdsArray);

            request.setAttribute("movieName", movieName);
            request.setAttribute("cinemaName", cinemaName);
            request.setAttribute("screenName", screenName);
            request.setAttribute("selectedSeats", selectedSeats);

            request.setAttribute("startTime", startTime);
            request.setAttribute("endTime", endTime);

            // Retrieve screenId from the request or session
            String screenIdParam = request.getParameter("screenId");
            int screenId;
            if (screenIdParam != null) {
                screenId = Integer.parseInt(screenIdParam);
            } else {
                Object screenIdSession = request.getSession().getAttribute("screenId");
                if (screenIdSession == null) {
                    throw new IllegalArgumentException("Screen ID is missing");
                }
                screenId = (int) screenIdSession;
            }

            // Retrieve voucherId from the request
            String voucherIdParam = request.getParameter("voucherId");
            Integer voucherId = null;
            if (voucherIdParam != null && !voucherIdParam.isEmpty()) {
                try {
                    voucherId = Integer.parseInt(voucherIdParam);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid voucherId: " + voucherIdParam);
                }
            }

            // Retrieve totalPrice from the request
            String totalPriceParam = request.getParameter("totalPrice");
            double totalPrice = 0.0;
            if (totalPriceParam != null && !totalPriceParam.isEmpty()) {
                totalPrice = Double.parseDouble(totalPriceParam);
            }

            // Debug log before creating the booking object
            System.out.println("Parsed Voucher ID: " + voucherId);
            System.out.println("Parsed Total Price: " + totalPrice);

            // Create a new booking object
            int movieId = (int) request.getSession().getAttribute("movieId");
            int cinemaId;
            Object cinemaIdSession = request.getSession().getAttribute("cinemaId");
            if (cinemaIdSession == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cinema ID is missing");
                return; // Stop further processing
            }
            cinemaId = (int) cinemaIdSession;
            if (!"done".equals(action)) {
                request.getRequestDispatcher("/confirmBooking.jsp").forward(request, response);
                return; // Dừng lại, không thực hiện đoạn code bên dưới
            }
            if ("done".equals(action)) {
                Booking booking = new Booking();
                booking.setCustomerId(customerId);
                booking.setShowtimeId(showtimeId);
                booking.setSeatId(seatIds.get(0)); // Assuming only one seat is selected
                booking.setScreenId(screenId);
                booking.setVoucherId(1); // Use the retrieved voucherId
                booking.setTotalPrice(totalPrice); // Use the retrieved totalPrice
                booking.setMovieId(movieId);
                booking.setCinemaId(cinemaId);
                booking.setBookingDate(new java.util.Date());

                // Debug log before saving to DB
                System.out.println("Booking object: " + booking);

                // Save the booking to the database
                BookingDAO bookingDAO = new BookingDAO();
                boolean isBookingSaved = bookingDAO.addBooking(booking);

                if (isBookingSaved) {
                    response.sendRedirect("movie"); // Redirect to a success page
                } else {
                    response.sendRedirect("error.jsp"); // Redirect to an error page
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        }
    }
}

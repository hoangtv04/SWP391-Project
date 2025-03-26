package dal;

import model.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookingDAO {
    public void insertBooking(Booking booking) throws Exception {
        String sql = "INSERT INTO Booking (CustomerID, MovieID, CinemaID, ScreenID, SeatID, ShowtimeID, TotalPrice) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getCustomerID());
            ps.setInt(2, booking.getMovieID());
            ps.setInt(3, booking.getCinemaID());
            ps.setInt(4, booking.getScreenID());
            ps.setInt(5, booking.getSeatID());
            ps.setInt(6, booking.getShowtimeID());
            ps.setDouble(7, booking.getTotalPrice());
            ps.executeUpdate();
        }
    }
}
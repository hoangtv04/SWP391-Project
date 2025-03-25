package model;

import java.util.Date;
import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private Date bookingDate;
    private double totalPrice;
    private String screenName;
    private String seatNumber;
    private Timestamp startTime;
    private String voucherCode;
    private String customerName;
    private String movieTitle;

    // Default constructor
    public Booking() {
    }

    // Parameterized constructor
    public Booking(int bookingId, Date bookingDate, double totalPrice, String screenName, String seatNumber, Timestamp startTime, String voucherCode, String customerName, String movieTitle) {
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
        this.screenName = screenName;
        this.seatNumber = seatNumber;
        this.startTime = startTime;
        this.voucherCode = voucherCode;
        this.customerName = customerName;
        this.movieTitle = movieTitle;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getScreenName() {
        return screenName;
    }

    public void setScreenName(String screenName) {
        this.screenName = screenName;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public Timestamp getStartTime() {
        return startTime;
    }

    public void setStartTime(Timestamp startTime) {
        this.startTime = startTime;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }
}

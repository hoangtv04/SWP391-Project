package model;

import java.util.Date;
import java.sql.Timestamp;

public class Booking {
    rivate int bookingId;
    private Date bookingDate;
    private double totalPrice;
    private String screenName;
    private String seatNumber;
    private Timestamp startTime;
    private String voucherCode;
    private String customerName;
    private String title;
    private int customerId;
    private int showtimeId;
    private int seatId;
    private int screenId;
    private int voucherId;

    // Constructor
    
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

    public void setBookingID(int bookingID) {
        this.BookingID = bookingID;
    }

public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int customerID) {
        this.CustomerID = customerID;
    }
    public Date getBookingDate() {
        return BookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.BookingDate = bookingDate;
    }

    public double getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.TotalPrice = totalPrice;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getScreenId() {
        return screenId;
    }

    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }
}
package model;

import java.util.Date;
import java.sql.Timestamp; // Sửa import từ jdk.jfr.Timestamp thành java.sql.Timestamp

public class Booking {
    private int bookingId;
    private Date bookingDate;
    private double totalPrice;
    private String screenName;
    private String seatNumber;
    private Timestamp startTime; // Sửa kiểu dữ liệu
    private String voucherCode;
    private String customerName;
    private String title;
    private int customerId;
    private int showtimeId;
    private int seatId;
    private int screenId;
    private int voucherId;
    private int movieId;
    private int cinemaId;
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
        this.title = title;
    }

    public Booking(int bookingId, Date bookingDate, double totalPrice, String screenName, String seatNumber, int customerId, int showtimeId, int seatId, int screenId, int voucherId) {
        this.bookingId = bookingId;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
        this.screenName = screenName;
        this.seatNumber = seatNumber;
        this.customerId = customerId;
        this.showtimeId = showtimeId;
        this.seatId = seatId;
        this.screenId = screenId;
        this.voucherId = voucherId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getCinemaId() {
        return cinemaId;
    }

    public void setCinemaId(int cinemaId) {
        this.cinemaId = cinemaId;
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
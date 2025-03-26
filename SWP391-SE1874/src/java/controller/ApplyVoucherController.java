/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.BookingDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Booking;

/**
 *
 * @author tovie
 */
@WebServlet(name="ApplyVoucherController", urlPatterns={"/applyvoucher"})
public class ApplyVoucherController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ApplyVoucherController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyVoucherController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Retrieve booking information from request parameters
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
        int seatId = Integer.parseInt(request.getParameter("seatId"));
        int screenId = Integer.parseInt(request.getParameter("screenId"));
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        double discountedPrice = Double.parseDouble(request.getParameter("discountedPrice"));

        // Create a new Booking object
        Booking booking = new Booking();
        booking.setCustomerId(customerId);
        booking.setShowtimeId(showtimeId);
        booking.setSeatId(seatId);
        booking.setScreenId(screenId);
        booking.setVoucherId(voucherId);
        booking.setTotalPrice(discountedPrice); // Use discounted price

        // Save the booking to the database
        BookingDAO bookingDAO = new BookingDAO();
        try {
            bookingDAO.saveBooking(booking);
        } catch (Exception ex) {
            Logger.getLogger(ApplyVoucherController.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Redirect to a confirmation page or display a success message
        response.sendRedirect("confirmation.jsp");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
package controller;

import dal.VoucherDAO;
import model.Voucher;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;

@WebServlet(name = "VoucherController", urlPatterns = {"/voucher"})
public class ManageVouchersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            VoucherDAO dao = new VoucherDAO();
            List<Voucher> vouchers = dao.getAllVouchers();
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("manageVouchers.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ManageVouchersController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        VoucherDAO dao = new VoucherDAO();

        try {
            if ("add".equals(action)) {
                String code = request.getParameter("code");
                String discount = request.getParameter("discount");
                String expiry = request.getParameter("expiry");
                Integer adminID = request.getParameter("admin").isEmpty() ? null : Integer.parseInt(request.getParameter("admin"));

                request.setAttribute("code", code);
                request.setAttribute("discount", discount);
                request.setAttribute("expiry", expiry);

                if (dao.isCodeExists(code)) {
                    request.setAttribute("error", "Mã voucher đã tồn tại.");
                    request.setAttribute("openAddPopup", true);
                } else if (Date.valueOf(expiry).toLocalDate().isBefore(LocalDate.now())) {
                    request.setAttribute("error", "Ngày hết hạn phải ở tương lai.");
                    request.setAttribute("openAddPopup", true);
                } else if (Integer.parseInt(discount) < 1 || Integer.parseInt(discount) > 100) {
                    request.setAttribute("error", "Discount phải nằm trong khoảng từ 1 đến 100.");
                    request.setAttribute("openAddPopup", true);
                } else {
                    dao.addVoucher(new Voucher(0, code, new BigDecimal(discount), Date.valueOf(expiry), adminID));
                    response.sendRedirect("voucher");
                    return;
                }
            } else if ("update".equals(action)) {
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));
                String code = request.getParameter("code");
                BigDecimal discount = new BigDecimal(request.getParameter("discount"));
                Date expiry = Date.valueOf(request.getParameter("expiry"));
                Integer adminID = request.getParameter("admin").isEmpty() ? null : Integer.parseInt(request.getParameter("admin"));

                if (expiry.toLocalDate().isBefore(LocalDate.now())) {
                    request.setAttribute("error", "Ngày hết hạn phải ở tương lai.");
                    request.getRequestDispatcher("manageVouchers.jsp").forward(request, response);
                    return;
                } else if (discount.intValue() < 1 || discount.intValue() > 100) {
                    request.setAttribute("error", "Discount phải nằm trong khoảng từ 1 đến 100.");
                    request.getRequestDispatcher("manageVouchers.jsp").forward(request, response);
                    return;
                } else {
                    dao.updateVoucher(new Voucher(voucherID, code, discount, expiry, adminID));
                    response.sendRedirect("voucher");
                    return;
                }
            } else if ("delete".equals(action)) {
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));
                dao.deleteVoucher(voucherID);
                response.sendRedirect("voucher");
                return;
            }
            // Reload the voucher list before forwarding
            List<Voucher> vouchers = dao.getAllVouchers();
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("manageVouchers.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ManageVouchersController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
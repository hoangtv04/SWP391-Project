package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StoreCinemaInSessionServlet", urlPatterns = {"/storeCinemaInSession"})
public class StoreCinemaInSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cinemaIdParam = request.getParameter("cinemaId");
        if (cinemaIdParam != null) {
            int cinemaId = Integer.parseInt(cinemaIdParam);
            request.getSession().setAttribute("cinemaId", cinemaId);
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cinema ID is missing");
        }
    }
}

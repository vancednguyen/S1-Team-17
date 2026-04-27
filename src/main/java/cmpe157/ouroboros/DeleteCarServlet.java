package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.carDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/Delete-Car")
public class DeleteCarServlet extends HttpServlet {
    private final carDao carDAO = new carDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int ownerId = (Integer) session.getAttribute("userId");
        String carId = request.getParameter("carId");

        carDAO.deleteCar(carId, ownerId);
        response.sendRedirect("Edit-Cars");
    }
}
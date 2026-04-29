package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.OwnerDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AccountEditServlet")
public class AccountEditServlet extends HttpServlet {
    private final OwnerDao ownerDao = new OwnerDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        // 1. Grab fields
        String userId = request.getParameter("userId");
        String newUserName = request.getParameter("username");
        String newEmail = request.getParameter("email");
        String newPhoneNumber = request.getParameter("phone");

        // 2. Validation
        if (userId == null || newUserName == null || newEmail == null || newPhoneNumber == null) {
            request.setAttribute("error", "All fields are required: " + userId + " " + newUserName + " " + newEmail + " " + newPhoneNumber);
            request.getRequestDispatcher("/accountEdit.jsp").forward(request, response);
            return;
        }

        // 3. Update database
        boolean success = ownerDao.updateOwner(userId, newUserName, newEmail, newPhoneNumber);

        if (success) {
            session.setAttribute("userName", newUserName);
            session.setAttribute("userEmail", newEmail);
            session.setAttribute("userPhoneNumber", newPhoneNumber);

            // Redirect back to profile or a success page
            response.sendRedirect("account.jsp?update=success");
        } else {
            request.setAttribute("error", "Update failed. Please try again.");
            request.getRequestDispatcher("/accountEdit.jsp").forward(request, response);
        }
    }
}

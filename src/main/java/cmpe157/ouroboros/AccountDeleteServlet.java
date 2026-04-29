package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.OwnerDao;
import cmpe157.ouroboros.dao.RenterDao;
import cmpe157.ouroboros.util.DBinfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AccountDeleteServlet")
public class AccountDeleteServlet extends HttpServlet {
    private final OwnerDao ownerDao = new OwnerDao();
    private final RenterDao renterDao = new RenterDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session.getAttribute("userEmail") != null) {
            String userId = request.getParameter("userId");

            boolean success = false;

            if(request.getParameter("userRole").equals("owner")){
                success = ownerDao.deleteOwner(userId);
            } else {
                success = renterDao.deleteRenter(userId);
            }

            if (success) {
                // 2. Log the user out
                session.invalidate();
                // 3. Redirect to homepage or signup with a success message
                response.sendRedirect("index.jsp?message=AccountDeleted");
            } else {
                response.sendRedirect("account.jsp?error=DeleteFailed");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }

}

package cmpe157.ouroboros;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Get session
        if (session != null) {
            session.invalidate(); // Clear all user data
        }
        response.sendRedirect("login.jsp?logout=success");
    }
}

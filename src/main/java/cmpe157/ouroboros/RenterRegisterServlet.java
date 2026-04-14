package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.RenterDao;
import cmpe157.ouroboros.model.Renter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RenterRegisterServlet")
public class RenterRegisterServlet extends HttpServlet {

    private final RenterDao renterDao = new RenterDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String license = request.getParameter("licenseNumber");
        String licenseExp = request.getParameter("licenseExpiration");

        if (username == null || username.isEmpty() ||
            email == null || email.isEmpty() ||
            password == null || password.isEmpty() ||
            phone == null || phone.isEmpty() ||
            license == null || license.isEmpty() ||
            licenseExp == null || licenseExp.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/renterRegister.jsp").forward(request, response);
            return;
        }

        if (renterDao.usernameExists(username)) {
            request.setAttribute("error", "Username already taken.");
            request.getRequestDispatcher("/renterRegister.jsp").forward(request, response);
            return;
        }

        if (renterDao.emailExists(email)) {
            request.setAttribute("error", "An account with that email already exists.");
            request.getRequestDispatcher("/renterRegister.jsp").forward(request, response);
            return;
        }

        Renter renter = new Renter();
        renter.setUsername(username);
        renter.setEmail(email);
        renter.setPassword(password);
        renter.setPhoneNumber(phone);
        renter.setDriversLicense(license);
        renter.setLicenseExp(licenseExp);

        boolean success = renterDao.registerRenter(renter);

        if (success) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/renterRegister.jsp").forward(request, response);
        }
    }
}
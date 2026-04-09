package cmpe157.ouroboros;

import cmpe157.ouroboros.dao.OwnerDao;
import cmpe157.ouroboros.model.Owner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OwnerRegisterServlet")
public class OwnerRegisterServlet extends HttpServlet {

    private final OwnerDao ownerDao = new OwnerDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Grab all form fields
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String license = request.getParameter("licenseNumber");
        String licenseExp = request.getParameter("licenseExpiration");
        String location = request.getParameter("location");

        // 2. Validate nothing is empty
        if (username == null || username.isEmpty() ||
            email == null || email.isEmpty() ||
            password == null || password.isEmpty() ||
            phone == null || phone.isEmpty() ||
            license == null || license.isEmpty() ||
            licenseExp == null || licenseExp.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/ownerRegister.jsp").forward(request, response);
            return;
        }

        // 3. Check for duplicates
        if (ownerDao.usernameExists(username)) {
            request.setAttribute("error", "Username already taken.");
            request.getRequestDispatcher("/ownerRegister.jsp").forward(request, response);
            return;
        }
        if (ownerDao.emailExists(email)) {
            request.setAttribute("error", "An account with that email already exists.");
            request.getRequestDispatcher("/ownerRegister.jsp").forward(request, response);
            return;
        }

        // 4. Build owner object
        Owner owner = new Owner();
        owner.setUsername(username);
        owner.setEmail(email);
        owner.setPassword(password);
        owner.setPhoneNumber(phone);
        owner.setDriversLicense(license);
        owner.setLicenseExp(licenseExp);
        owner.setLocation(location != null ? location : "");

        // 5. Save to database
        boolean success = ownerDao.registerOwner(owner);

        if (success) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/ownerRegister.jsp").forward(request, response);
        }
    }
}
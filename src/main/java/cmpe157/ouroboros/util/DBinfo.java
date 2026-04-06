package cmpe157.ouroboros.util;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBinfo { //change the user and password to yours more
    private static final String URL = "jdbc:mysql://localhost:3306/ouroboro_ev";
    private static final String USER = "root";
    private static final String PASSWORD = "4200";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

package cmpe157.ouroboros.model;

public class User {
    private int userId;
    private String username;
    private String email;
    private String phoneNumber;
    private String driversLicense;
    private String licenseExp;
    private String role; // "owner" or "renter"

    public User() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getDriversLicense() { return driversLicense; }
    public void setDriversLicense(String driversLicense) { this.driversLicense = driversLicense; }

    public String getLicenseExp() { return licenseExp; }
    public void setLicenseExp(String licenseExp) { this.licenseExp = licenseExp; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
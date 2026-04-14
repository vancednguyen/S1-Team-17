package cmpe157.ouroboros.model;

public class Renter {
	private String userId;
	private String username;
    private String email;
    private String password;
    private String phoneNumber;
    private String driversLicense;
    private String licenseExp;

    public Renter() {}

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getDriversLicense() { return driversLicense; }
    public void setDriversLicense(String driversLicense) { this.driversLicense = driversLicense; }

    public String getLicenseExp() { return licenseExp; }
    public void setLicenseExp(String licenseExp) { this.licenseExp = licenseExp; }
}

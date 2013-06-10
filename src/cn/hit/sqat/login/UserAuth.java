package cn.hit.sqat.login;

public final class UserAuth {

    private final String userId;

    private final String passwordHash;

    private final String username;

    private final UserType userType;

    public UserAuth(final String userId, final String passwordHash, final UserType userType, final String username) {
        this.userId = userId;
        this.passwordHash = passwordHash;
        this.userType = userType;
        this.username = username;
    }

    public String getUserId() {
        return userId;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public UserType getUserType() {
        return userType;
    }

    public String getUsername() {
        return username;
    }

    public boolean hasCredentials() {
        return (userId != null && !userId.isEmpty() && !userId.equals("null")) &&
                (passwordHash != null && !passwordHash.isEmpty() && !passwordHash.equals("null")) && userType != null;
    }
}
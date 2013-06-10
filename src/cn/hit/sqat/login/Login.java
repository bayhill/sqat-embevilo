package cn.hit.sqat.login;

import cn.hit.sqat.info.Database;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public final class Login {

    public static final String FIELD_USER_ID = "username";

    public static final String FIELD_USER_NAME = "name";

    public static final String FIELD_USER_PASSWORD_HASH = "password";

    public static final String FIELD_USER_TYPE = "usertype";

    public enum Error {

        NONE(0, ""),
        NO_CREDENTIALS_STORED(1, "You need to login before accessing this resource."),
        INVALID_CREDENTIALS(2, "The username and password combination is not valid."),
        NO_DATABASE_CONNECTION(3, "No database connection is available, try again soon."),
        UNKNOWN(4, "Unknown error occurred while trying to sign in."),
        MISSING_USERNAME(5, "You need to specify a username."),
        MISSING_PASSWORD(6, "You need to specify a password."),
        INSUFFICIENT_RIGHTS(7, "You do not have the rights to access that page.");

        private static final Map<Integer, Error> ID_MAP;

        static {
            final Map<Integer, Error> mapId = new HashMap<Integer, Error>();
            for(final Error error : Error.values())
                mapId.put(error.getId(), error);

            ID_MAP = Collections.unmodifiableMap(mapId);
        }

        public static Error fromId(final int id) {
            return ID_MAP.get(id);
        }

        private final int id;

        private final String message;

        private Error(final int id, final String message) {
            this.id = id;
            this.message = message;
        }

        public int getId() {
            return id;
        }

        public String getMessage() {
            return message;
        }

        public String getRedirect() {
            return "index.jsp?id=" + id;
        }
    }

    public static UserAuth getUserAuthentication(final HttpServletRequest request) {
        return new UserAuth(String.valueOf(request.getParameter(FIELD_USER_ID)), String.valueOf(request.
                getParameter(FIELD_USER_PASSWORD_HASH)), UserType.fromId(String.valueOf(request.
                getParameter(FIELD_USER_TYPE))), String.valueOf(request.getParameter(FIELD_USER_NAME)));
    }

    public static UserAuth getUserAuthentication(final HttpSession session) {
        return new UserAuth(String.valueOf(session.getAttribute(FIELD_USER_ID)), String.valueOf(session.
                getAttribute(FIELD_USER_PASSWORD_HASH)), UserType.fromId(String.valueOf(session.
                getAttribute(FIELD_USER_TYPE))), String.valueOf(session.getAttribute(FIELD_USER_NAME)));
    }

    public static Error isAuthenticated(final HttpSession session) {
        return isAuthenticated(getUserAuthentication(session), null);
    }

    public static Error isAuthenticated(final HttpServletRequest request) {
        return isAuthenticated(getUserAuthentication(request), null);
    }

    public static Error isAuthenticated(final HttpServletRequest request, final HttpSession session) {
        return isAuthenticated(getUserAuthentication(request), session);
    }

    public static Error isAuthenticated(final UserAuth userAuth, final HttpSession session) {
        if(userAuth.getUserId().isEmpty())
            return Error.MISSING_USERNAME;

        if(userAuth.getPasswordHash().isEmpty())
            return Error.MISSING_PASSWORD;

        if(!userAuth.hasCredentials())
            return Error.NO_CREDENTIALS_STORED;

        try {
            Database.connect();
            if(Database.isConnected()) {
                final ResultSet resultSet = Database.query("SELECT Name, PasswordHash FROM " +
                        userAuth.getUserType().getTable() + " WHERE " + userAuth.getUserType().getKey() +
                        " = " + userAuth.getUserId());

                if(resultSet != null) {
                    try {
                        if(resultSet.next() && userAuth.getPasswordHash().equals(resultSet.getString(2))) {
                            if(session != null) {
                                session.setAttribute(FIELD_USER_NAME, resultSet.getString(1));
                                session.setAttribute(FIELD_USER_ID, userAuth.getUserId());
                                session.setAttribute(FIELD_USER_PASSWORD_HASH, userAuth.getPasswordHash());
                                session.setAttribute(FIELD_USER_TYPE, userAuth.getUserType().getId());
                            }

                            return Error.NONE;
                        } else return Error.INVALID_CREDENTIALS;
                    } catch(final SQLException e) {
                        e.printStackTrace();
                    }
                } else return Error.INVALID_CREDENTIALS;
            } else return Error.NO_DATABASE_CONNECTION;
        } finally {
            Database.disconnect();
        }

        return Error.UNKNOWN;
    }

    public static boolean hasPageAccessRights(final HttpSession session, final HttpServletRequest request) {
        final String pageRequest = request.getRequestURI();
        final String pageName = pageRequest.substring(pageRequest.lastIndexOf('/')),
            pageNameAlt = pageName.substring(0, pageName.length() - 4);

        final UserType userType = Login.getUserAuthentication(session).getUserType();
        final Collection<String> menuPages = userType.getMenuLinks().values();

        return menuPages.contains(pageName) || menuPages.contains(pageNameAlt)
                || userType.getNavbarLinks().values().contains(pageName);
    }
}
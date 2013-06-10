package cn.hit.sqat.login;

import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public enum UserType {

    GUNSMITH("Gunsmith", "gunsmith", "gunsmithid") {
        @Override
        public Map<String, String> getMenuLinks() {
            final Map<String, String> menuLinks = new LinkedHashMap<String, String>();
            menuLinks.put("Home", "/home.jsp");
            menuLinks.put("Sales", "/sales.jsp");
            menuLinks.put("Production", "/production");
            menuLinks.put("Commission", "/commission.jsp");
            return menuLinks;
        }

        @Override
        public Map<String, String> getNavbarLinks() {
            final Map<String, String> navbarLinks = new LinkedHashMap<String, String>();
            navbarLinks.put("Home", "/home.jsp");
            navbarLinks.put("About", "/about.jsp");
            navbarLinks.put("Contact", "/contact.jsp");
            return navbarLinks;
        }
    },

    SALESMAN("Salesman", "salesman", "salesmanid") {
        @Override
        public Map<String, String> getMenuLinks() {
            final Map<String, String> menuLinks = new LinkedHashMap<String, String>();
            menuLinks.put("Home", "/home.jsp");
            menuLinks.put("New Sale", "/newsale");
            menuLinks.put("Sales", "/sales");
            menuLinks.put("Commission", "/sm_commission.jsp");
            return menuLinks;
        }

        @Override
        public Map<String, String> getNavbarLinks() {
            final Map<String, String> navbarLinks = new LinkedHashMap<String, String>();
            navbarLinks.put("Home", "/home.jsp");
            navbarLinks.put("About", "/about.jsp");
            navbarLinks.put("Contact", "/contact.jsp");
            return navbarLinks;
        }
    };

    private static final Map<String, UserType> ID_MAP;

    static {
        final Map<String, UserType> mapId = new HashMap<String, UserType>();
        for(final UserType userType : UserType.values())
            mapId.put(userType.getId(), userType);

        ID_MAP = Collections.unmodifiableMap(mapId);
    }

    public static UserType fromId(final String id) {
        return ID_MAP.get(id);
    }

    private final String id;

    private final String table;

    private final String key;

    private UserType(final String id, final String table, final String key) {
        this.id = id;
        this.table = table;
        this.key = key;
    }

    public String getId() {
        return id;
    }

    public String getTable() {
        return table;
    }

    public String getKey() {
        return key;
    }

    public abstract Map<String, String> getMenuLinks();

    public abstract Map<String, String> getNavbarLinks();
}

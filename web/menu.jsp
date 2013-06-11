<%@ page import="cn.hit.sqat.login.UserType" %>
<%@ page import="java.util.Map" %>
<%@ page import="cn.hit.sqat.login.Login" %>

<div class="well sidebar-nav">
    <ul class="nav nav-list">
        <li class="nav-header">Menu</li>

        <%
            final String currentRequest = request.getRequestURI();
            final String pageName = currentRequest.substring(currentRequest.lastIndexOf('/'));

            final UserType userType = Login.getUserAuthentication(session).getUserType();
            for(final Map.Entry<String, String> menuEntry : userType.getMenuLinks().entrySet()) {
                final String menuEntryPage = menuEntry.getValue().endsWith(".jsp") ?
                        menuEntry.getValue() : menuEntry.getValue() + ".jsp";

                if(menuEntryPage.equalsIgnoreCase(pageName)) {
                    %><li class="active"><a href="<%=menuEntry.getValue()%>"><%=menuEntry.getKey()%></a></li><%
                } else {
                    %><li><a href="<%=menuEntry.getValue()%>"><%=menuEntry.getKey()%></a></li><%
                }
            }
        %>
    </ul>
</div>
<!--/.well -->
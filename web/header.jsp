<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.UserType" %>
<%@ page import="java.util.Map" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container-fluid">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="home.jsp"><%=Project.getTitle()%>
            </a>

            <div class="nav-collapse collapse">
                <p class="navbar-text pull-right">
                    Logged in as <%=Login.getUserAuthentication(session).getUsername()%>
                    (<%=Login.getUserAuthentication(session).getUserType().getId()%>).
                    <a href="logout.jsp" class="navbar-link">Log out</a>.
                </p>
                <ul class="nav">
                    <%
                        final String currentRequest = request.getRequestURI();
                        final String pageName = currentRequest.substring(currentRequest.lastIndexOf('/'));

                        final UserType userType = Login.getUserAuthentication(session).getUserType();
                        for(final Map.Entry<String, String> menuEntry : userType.getNavbarLinks().entrySet()) {
                            boolean active = false;
                            if(menuEntry.getKey().equals("Home")) {


                                active = userType.getMenuLinks().values().contains(pageName);
                                if(!active && pageName.endsWith(".jsp")) {
                                    active = userType.getMenuLinks().values().contains(pageName.substring(0, pageName.length() - 4));
                                }
                            }

                            if(active || menuEntry.getValue().equalsIgnoreCase(pageName)) {
                                %><li class="active"><a href="<%=menuEntry.getValue()%>"><%=menuEntry.getKey()%></a></li><%
                            } else {
                                %><li><a href="<%=menuEntry.getValue()%>"><%=menuEntry.getKey()%></a></li><%
                            }
                        }
                    %>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
</div>
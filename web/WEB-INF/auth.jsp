<%@ page import="cn.hit.sqat.login.Login" %>
<%
    Login.Error error = Login.isAuthenticated(session);
    if(error == Login.Error.NONE && !Login.hasPageAccessRights(session, request))
        error = Login.Error.INSUFFICIENT_RIGHTS;

    if (error != Login.Error.NONE) {
        response.sendRedirect(error.getRedirect());
        return;
    }
%>
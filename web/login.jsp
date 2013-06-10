<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%
    final Login.Error error = Login.isAuthenticated(request, session);
    if(error == Login.Error.NONE)
        response.sendRedirect("home.jsp");
    else {
        response.sendRedirect(error.getRedirect());
    }
%>

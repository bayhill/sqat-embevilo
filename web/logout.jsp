<%@ page import="cn.hit.sqat.login.Login" %>
<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
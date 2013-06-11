<%--
  Created by IntelliJ IDEA.
  User: Emil
  Date: 2013-06-10
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="cn.hit.sqat.info.Database" %>
<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="auth.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%=Project.getPageTitle("Sales")%>
    </title>
    <script src="assets/js/jquery.js"></script>
    <script type="text/javascript" src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <link href="assets/css/jquery-ui-1.10.3.custom.css" rel="stylesheet">
    <script type="text/javascript">
        $(function () {
            $('#datepicker').datepicker({
                changeMonth: true,
                changeYear: true,
                showButtonPanel: true,
                dateFormat: 'MM yy',
                onClose: function (dateText, inst) {
                    var month = $("#ui-datepicker-div").find(".ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div").find(".ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, 1));
                }
            });
        });
    </script>
    <style type="text/css">

        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }

        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }

        .ui-datepicker-calendar {
            display: none;
        }
    </style>
</head>
<body>
<jsp:include page="/header.jsp"/>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span3">
            <jsp:include page="/menu.jsp"/>
        </div>
        <!--/span-->
        <div class="span9">
            <div class="row-fluid">
                <div class="span12">
                    <h2>Sales</h2>
                    <table>
                        <tr>
                            <form method="POST" title="dateform">
                                <td><label for="datepicker">Period:</label>
                                </td>
                                <td><input name="datepicker" type="text" id="datepicker" style="margin-bottom: 0"
                                           class="ui-datepicker"/>
                                </td>
                                <td>
                                    <button name="viewBtn" id="view" class="btn btn-success">
                                        View
                                    </button>
                                </td>
                            </form>
                        </tr>
                    </table>
                    <%
                        final SimpleDateFormat dateFormat = new SimpleDateFormat("MMMMMMMMMM yyyy", Locale.US);
                        final String viewDateString = request.getParameter("datepicker");

                        Date viewDate;
                        if(viewDateString == null)
                            viewDate = new Date();
                        else {
                            try {
                                viewDate = dateFormat.parse(viewDateString);
                            } catch(final ParseException e) {
                                viewDate = new Date();
                            }
                        }

                        final String period = dateFormat.format(viewDate);
                        final GregorianCalendar gc = new GregorianCalendar();
                        gc.setTime(viewDate);

                        final int year = gc.get(Calendar.YEAR), month = 1 + gc.get(Calendar.MONTH);
                    %>
                    <div style="margin-top: 2px">Currently displaying sales for <%=period%>.</div>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>
                                <h3>Locks</h3>
                            </th>
                        </tr>
                        <tr>
                            <th>Date</th>
                            <th>Quantity</th>
                            <th>Value</th>
                            <th>Gunsmith</th>
                            <th>City</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${locksales}" var="locksale">
                            <tr>
                                <td>${locksale.date}</td>
                                <td>${locksale.quantity}</td>
                                <td>${locksale.value}</td>
                                <td>${locksale.actor}</td>
                                <td>${locksale.city}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <b>Total Value:</b> $${locksalestotal[0]}<br/>
                    <b>Total Quantity:</b> ${locksalestotal[1]}<br/>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>
                                <h3>Stocks</h3>
                            </th>
                        </tr>
                        <tr>
                            <th>Date</th>
                            <th>Quantity</th>
                            <th>Value</th>
                            <th>Gunsmith</th>
                            <th>City</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${stocksales}" var="stocksale">
                            <tr>
                                <td>${stocksale.date}</td>
                                <td>${stocksale.quantity}</td>
                                <td>${stocksale.value}</td>
                                <td>${stocksale.actor}</td>
                                <td>${stocksale.city}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <b>Total Value:</b> $${stocksalestotal[0]}<br/>
                    <b>Total Quantity:</b> ${stocksalestotal[1]}<br/>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>
                                <h3>Barrells</h3>
                            </th>
                        </tr>
                        <tr>
                            <th>Date</th>
                            <th>Quantity</th>
                            <th>Value</th>
                            <th>Gunsmith</th>
                            <th>City</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${barrellsales}" var="barrelsale">
                            <tr>
                                <td>${barrelsale.date}</td>
                                <td>${barrelsale.quantity}</td>
                                <td>${barrelsale.value}</td>
                                <td>${barrelsale.actor}</td>
                                <td>${barrelsale.city}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <b>Total Value:</b> $${barrellsalestotal[0]}<br/>
                    <b>Total Quantity:</b> ${barrellsalestotal[1]} <br/><br/>
                </div>
                <b>Total Sales Value:</b> $${salestotal[0]}<br/>
                <b>Total Sales Quantity:</b> ${salestotal[1]}
                <!--/span-->
            </div>
            <!--/row-->
        </div>
        <!--/span-->
    </div>
    <!--/row-->
    <div class="row-fluid">

    </div>
    <hr>

    <footer>
        <p><%=Project.getCopyright()%></p>
    </footer>

</div>
</body>
</html>
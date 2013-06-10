<%@ page import="cn.hit.sqat.info.Database" %>
<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Locale" %>

<%@include file="/WEB-INF/auth.jsp"%>
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

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

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
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span3">
                <jsp:include page="menu.jsp"/>
            </div>
            <!--/span-->
            <div class="span9">
                <div class="row-fluid">
                    <div class="span12">
                        <h2>Sales</h2>
                        <table>
                            <tr>
                                <form title="dateform">
                                    <td><input name="datepicker" type="text" id="datepicker" style="margin-bottom: 0"
                                               class="ui-datepicker"/>
                                    </td>
                                    <td>
                                        <button name="view" id="view" value="1" class="btn btn-success">View</button>
                                    </td>
                                    <td>
                                        <div id="response"></div>
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
                        <br/>
                            <%
                                Database.connect();
                                ResultSet rs = Database.query("SELECT s.date, gp.description, s.quantity, s.quantity*p.price, sm.name, c.name " +
                                        "FROM Sales s, Salesman sm, City c, Gunpart gp, Production p " +
                                        "WHERE s.gunsmithid = " + Login.getUserAuthentication(session).getUserId() + " " +
                                        "AND gp.gunpartid = s.gunpartid " +
                                        "AND sm.salesmanid = s.salesmanid " +
                                        "AND c.cityid = s.cityid " +
                                        "AND p.gunsmithid = s.gunsmithid " +
                                        "AND p.gunpartid = s.gunpartid " +
                                        "AND YEAR(s.date) = " + year + " " +
                                        "AND MONTH(s.date) = " + month + " " +
                                        "ORDER BY s.date DESC");

                                boolean first = true;
                                while(rs.next()) {
                                    if(first) {
                                        %>
                                            <table class="table">
                                                <thead>
                                                <tr>
                                                    <th>Date</th>
                                                    <th>Part</th>
                                                    <th>Quantity</th>
                                                    <th>Value</th>
                                                    <th>Salesman</th>
                                                    <th>City</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                        <%

                                        first = false;
                                    }
                            %>
                            <tr>
                                <td><%=rs.getString(1)%>
                                </td>
                                <td><%=rs.getString(2)%>
                                </td>
                                <td><%=rs.getString(3)%>
                                </td>
                                <td>$<%=rs.getString(4)%>
                                </td>
                                <td><%=rs.getString(5)%>
                                </td>
                                <td><%=rs.getString(6)%>
                                </td>
                            </tr>
                            <%
                                }
                                Database.disconnect();

                                if(first)  { // No rows
                                    %>There are no entries available for the selected time period.<%
                                }
                            %>
                            </tbody>
                        </table>
                    </div>
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
            <p><%=Project.getCopyright()%>
            </p>
        </footer>

    </div>
</body>
</html>
            
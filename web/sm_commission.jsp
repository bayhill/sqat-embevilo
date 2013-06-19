<%@ page import="cn.hit.sqat.info.Database" %>
<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="/WEB-INF/auth.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%=Project.getPageTitle("Commission")%>
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

    <!-- Le styles -->
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
                        <h2>Commission</h2>
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
                        <div style="margin-top: 2px">Currently displaying commission for <%=period%>.</div>
                        <%
                            Database.connect();
                            final ResultSet rs = Database.query("SELECT s.gunsmithid, gs.name, s.gunpartid, " +
                                    "gp.description, SUM(s.quantity), SUM(s.quantity*p.price) FROM sales s," +
                                    " gunsmith gs, gunpart gp, production p WHERE s.salesmanid = " +
                                    Login.getUserAuthentication(session).getUserId() + " " +
                                    "AND YEAR(s.date) = " + year + " " +
                                    "AND MONTH(s.date) = " + month + " " +
                                    "AND gs.gunsmithid = s.gunsmithid " +
                                    "AND gp.gunpartid = s.gunpartid AND p.gunsmithid = s.gunsmithid AND " +
                                    "p.gunpartid = s.gunpartid GROUP BY s.gunsmithid, s.gunpartid " +
                                    "ORDER BY s.gunsmithid, s.gunpartid");

                            if(rs.next()) {
                                int overallTotal = 0, overallCommission = 0;
                                while(!rs.isAfterLast()) {
                                    int currentSalesman = rs.getInt(1), total = 0;
                                    %><br/><h4><%="(" + rs.getString(1) + ") " + rs.getString(2)%></h4>
                                        <table class="table">
                                        <thead>
                                        <tr>
                                            <th>Part ID</th>
                                            <th>Gun Part</th>
                                            <th>Quantity</th>
                                            <th>Value</th>
                                        </tr>
                                        </thead>
                                        <tbody><%

                                    while(rs.getInt(1) == currentSalesman) {
                                        total += rs.getInt(6);

                                        %>
                                        <tr>
                                            <td><%=rs.getString(3)%></td>
                                            <td><%=rs.getString(4)%></td>
                                            <td><%=rs.getString(5)%></td>
                                            <td>$<%=rs.getString(6)%></td>
                                        </tr>
                                        <%

                                        if(!rs.next())
                                            break;
                                    }

                                            overallTotal += total;
                                            final int commission = Project.calculateCommission(total);
                                            overallCommission += commission;

                                        %>
                                            </tbody>
                                        </table>
                                        <b>Total Value:</b> $<%=total%><br/>
                                        <b>Commission:</b> $<%=commission%><br/>
                                        <%
                                }
                            %>
                            <hr>
                            <h4>Summary</h4>
                            <table class="table">
                            <thead>
                            <tr>
                                <th>Part ID</th>
                                <th>Gun Part</th>
                                <th>Quantity</th>
                                <th>Value</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%

                                final ResultSet summarySet = Database.query("SELECT s.gunpartid, gp.description, " +
                                        "SUM(s.quantity), SUM(s.quantity*p.price) FROM sales s, gunpart gp, production p " +
                                        "WHERE s.salesmanid = " + Login.getUserAuthentication(session).getUserId() + " " +
                                        "AND YEAR(s.date) = " + year + " " +
                                        "AND MONTH(s.date) = " + month + " " +
                                        "AND gp.gunpartid = s.gunpartid " +
                                        "AND p.gunsmithid = s.gunsmithid AND p.gunpartid = s.gunpartid " +
                                        "GROUP BY s.gunpartid ORDER BY s.gunpartid");

                                while(summarySet.next()) {
                                    %>

                                    <tr>
                                        <td><%=summarySet.getString(1)%></td>
                                        <td><%=summarySet.getString(2)%></td>
                                        <td><%=summarySet.getString(3)%></td>
                                        <td>$<%=summarySet.getString(4)%></td>
                                    </tr>
                                    <%
                                }
                            %>
                            </tbody>
                            </table>
                            <b>Total Value:</b> $<%=overallTotal%><br/>
                            <b>Commission:</b> $<%=overallCommission%><br/>
                        <%
                        } else {
                            %><br/>There are no entries available for the selected time period.<%
                        }
                    %>
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
    <!--/.fluid-container-->
</body>
</html>
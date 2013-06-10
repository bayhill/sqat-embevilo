<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@include file="auth.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%=Project.getPageTitle("Production")%>
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
                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, 1));
                    alert(month + " " + year);
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
                    <h2>Production</h2>
                    <table class="table">
                        <thead>
                        <tr>
                            <th>Gun Part ID</th>
                            <th>Description</th>
                            <th>Monthly limit</th>
                            <th>Price</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${production}" var="production">
                            <tr>
                                <td>${production.gunpartid}</td>
                                <td>${production.description}</td>
                                <td>${production.monthlylimit}</td>
                                <td>${production.price}</td>
                            </tr>
                        </c:forEach>
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
        <p><%=Project.getCopyright()%></p>
    </footer>

</div>
</body>
</html>
<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
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
                    var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                    var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                    $(this).datepicker('setDate', new Date(year, month, 1));
                }
            });
        });
        function clearfields(){
            document.getElementById('inputsale').reset();
        }
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
                <div class="span6">
                    <form id="inputsale" method="POST">
                        <fieldset>
                            <h2>New sale</h2>
                            <div class="row-fluid">
                                <div class="span4">
                                    <label><b>Gunsmith</b></label>
                                    <select name="gunsmith">
                                        <c:forEach items="${gunsmiths}" var="gunsmith">
                                            <option value="${gunsmith.gunsmithid}">${gunsmith.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="span4">
                                    <label><b>City</b></label>
                                    <select name="city">
                                        <c:forEach items="${cities}" var="city">
                                            <option value="${city.cityid}">${city.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="span4">
                                    <label for="datepicker"><b>Period</b></label>
                                    <input name="datepicker" type="text" id="datepicker" style="margin-bottom: 0"
                                           class="ui-datepicker"/>
                                </div>
                            </div>
                            <br/>
                            <table class="table">
                                <tr>
                                    <td><b>Locks</b></td>
                                    <td>
                                        <input name="locks" type="number" style="width: 45px; padding: 1px" min="1"
                                               value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Stocks</b></td>
                                    <td>
                                        <input name="stocks" type="number" style="width: 45px; padding: 1px" min="1"
                                               value="1">
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Barrells</b></td>
                                    <td>
                                        <input name="barrells" type="number" style="width: 45px; padding: 1px" min="1"
                                               value="1">
                                    </td>
                                </tr>
                            </table>
                            <button type="submit" class="btn btn-primary">Confirm</button>
                            <button type="button" class="btn" onclick="clearfields()">Reset</button>
                        </fieldset>
                    </form>
                    <c:choose>
                        <c:when test="${result == 'fail'}">
                            <div class="alert alert-error">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Failure!</strong> The new sale order was not submitted.
                            </div>
                        </c:when>
                        <c:when test="${result == 'success'}">
                            <div class="alert alert-success">
                                <button type="button" class="close" data-dismiss="alert">&times;</button>
                                <strong>Success!</strong> The new sale order was submitted.
                            </div>
                        </c:when>
                    </c:choose>
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
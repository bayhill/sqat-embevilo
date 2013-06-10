<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page import="cn.hit.sqat.login.UserType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if(Login.isAuthenticated(session) == Login.Error.NONE) {
        response.sendRedirect("home.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%=Project.getPageTitle("Login")%>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }

        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }

    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="assets/ico/favicon.png">
</head>

<body>

    <div class="container">

        <form class="form-signin" action="login.jsp" method="post">
            <h2 class="form-signin-heading">Please sign in</h2>
            <label title="<%=Login.FIELD_USER_ID%>">
                <input type="text" name="<%=Login.FIELD_USER_ID%>" class="input-block-level" placeholder="Username">
            </label>
            <label title="<%=Login.FIELD_USER_PASSWORD_HASH%>">
                <input type="password" name="<%=Login.FIELD_USER_PASSWORD_HASH%>" class="input-block-level"
                       placeholder="Password">
            </label>
            <label title="<%=Login.FIELD_USER_TYPE%>">
                <select name="<%=Login.FIELD_USER_TYPE%>">
                    <%
                        for(final UserType userType : UserType.values()) {
                    %>
                    <option value="<%=userType.getId()%>"><%=userType.getId()%>
                    </option>
                    <%
                        }
                    %>
                </select>
            </label>
            <button class="btn btn-large btn-primary" type="submit">Sign in</button>
            <div style="margin-top: 10px">
                <%
                    final String errorIdString = request.getParameter("id");
                    if(errorIdString != null) {
                        int errorId = -1;
                        try {
                            errorId = Integer.parseInt(errorIdString);
                        }catch(final NumberFormatException ignored) {}

                        final Login.Error error = Login.Error.fromId(errorId);
                        if(error != null) {
                            %>Error: <%=error.getMessage()%><%
                        }
                    }
                %>
            </div>
        </form>

    </div>
    <!-- /container -->

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>

</body>
</html>

<%@ page import="cn.hit.sqat.info.Project" %>
<%@ page import="cn.hit.sqat.login.Login" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="/WEB-INF/auth.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%=Project.getPageTitle("Home")%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
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
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
        <div class="row-fluid">
            <!--/span-->
            <div class="span6">
                <div class="row-fluid">
                    <div class="span12">
                        <h2>Contact</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tristique pretium urna, sit amet laoreet odio. Donec tincidunt in tellus quis euismod. Suspendisse nisi nibh, ornare non risus ac, congue lacinia enim. Aenean rutrum feugiat viverra. Integer ligula sapien, congue ac pretium nec, aliquam a metus. Pellentesque at mi vulputate, varius dui a, gravida nisl. Maecenas quis pretium leo. Nulla vehicula ligula at.</p>
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
    <!--/.fluid-container-->

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
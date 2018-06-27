<%-- 
    Document   : index
    Created on : Jun 13, 2018, 2:52:02 PM
    Author     : HelloThang
--%>

<%@page import="java.util.TreeMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Hashtable"%>
<%@page import="org.json.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page import="java.util.List" %>
<%@ page import="controller.*" %>

<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SERVER CONFIG</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"> 
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <meta name="description" content="Perspective Page View Navigation: Transforms the page in 3D to reveal a menu" />
        <meta name="keywords" content="3d page, menu, navigation, mobile, perspective, css transform, web development, web design" />
        <meta name="author" content="Codrops" />
        <link rel="shortcut icon" href="../favicon.ico">
        <link rel="stylesheet" type="text/css" href="css/table.css">
        <!-- csstransforms3d-shiv-cssclasses-prefixed-teststyles-testprop-testallprops-prefixes-domprefixes-load --> 
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

        <!--===============================================================================================-->
        <script src="js/modernizr.custom.25376.js"></script>
        <script src="js/checkTokenInvalid.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>

    </head>
    <body >

        <% SendAPI send = new SendAPI();
            JSONObject js = new JSONObject();
            js.put("api", "get_config");
            String URL = constant.Constant.LOCAL_STF;
            send.SaveWorkFlow(URL, js);
            TreeMap<String, String> hs = send.getAllAPI();
            request.setAttribute("hs", hs);
        %>
        <div style="position: relative;z-index: 99">
            <nav>
                <a href="main.jsp" class="icon-home">Main</a>
                <a href="backend.jsp" class="icon-news">Back End</a>
                <a href="buzz.jsp" class="icon-image">Buzz</a>
                <a href="chat.jsp" class="icon-upload">Chat</a>
                <a href="JPNS.jsp" class="icon-star">JPNS</a>
                <a href="meet.jsp" class="icon-mail">Meet People</a>
                <a href="stf.jsp" class="icon-lock">Static File</a>
                <a href="ums.jsp" class="icon-lock">User Managerment</a>
                <a href="#" id="logout" class="icon-lock">Log Out </a>

                <div class="animation start-stf"></div>
                <canvas style="width: 100%; height:100%"></canvas>
            </nav>
        </div>
        <div style="margin-top: 50px"></div>
        <div class="limiter">
            <div class="container-table100">
                <div class="wrap-table100">
                    <div class="table100 ver5 m-b-110">
                        <table style="table-layout: fixed; width: 100%" data-vertable="ver5">
                            <colgroup>
                                <col span="1" style="width: 20%;">
                                <col span="1" style="width: 70%;">
                                <col span="1" style="width: 10%;">
                            </colgroup>
                            <thead >
                                <tr class="row100 head" >
                                    <td class="column100 column1" data-column="column1">KEY</td>
                                    <td class="column100 column2" data-column="column2">VALUE</td>
                                    <td class="column100 column3" data-column="column3">UPDATE</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="country" items="${hs}">
                                    <c:if test = "${!fn:contains(country.key, 'PUBLIC_KEY')}">
                                    <form id="form${country.key}" action="SendAndReadAPI" method="POST" class="w3-container" onsubmit="myFunction('${country.key}')">
                                        <tr class="row100">
                                            <td class="column100 column1" data-column="column1">  <c:out value="${country.key}"/>  </td>
                                            <td id="${country.key}" contenteditable="true"  style="word-wrap: break-word;" class="column100 column2" data-column="column2" onkeyup="myFunctionKeypress('${country.key}', '${country.value}')"> 
                                                <c:out value="${country.value}"/> 
                                            </td>
                                            <td class="column100 column3" data-column="column3">
                                                <input  type="hidden" name="key" value="${country.key}"> 
                                                <input id="edited${country.key}" type="hidden" name="value" value="abc">  
                                                <input  type="hidden" name="app" value="stf">  
                                                <input id="token${country.key}"  type="hidden" name="token">  
                                                <input disabled="true" id="button${country.key}" class="w3-btn w3-blue-grey" type="submit" value="Update" name="update" onclick="callJavaScriptServlet('${country.key}')" /> 
                                            </td>
                                        </tr>
                                    </form>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div> 
                </div>
            </div>
        </div>
        <script src="js/main.js"></script>
        <script src="js/buttonsubmit.js"></script>
        <script type="text/javascript">
                                                    (function ($) {
                                                        function processForm(e) {
                                                            if (localStorage.token == null)
                                                                window.location = "index.jsp";
                                                            $.ajax({
                                                                url: '<%=constant.Constant.LOCAL_MAIN%>',
                                                                dataType: 'json',
                                                                type: 'post',
                                                                contentType: 'application/json',
                                                                data: JSON.stringify({"token": localStorage.token, "api": "lst_role"}),
                                                                processData: false,
                                                                success: function (data, textStatus, jQxhr) {
                                                                    if (data.code != 0) {
                                                                        window.location = "index.jsp";
                                                                    }
                                                                },
                                                                error: function (jqXhr, textStatus, errorThrown) {
                                                                    console.log(errorThrown);
                                                                }
                                                            });
                                                        }
                                                        window.onunload = processForm();
                                                    })(jQuery);

        </script>
        <script type="text/javascript">
            (function ($) {
                function processForm(e) {
                    $.ajax({
                        url: '<%=constant.Constant.LOCAL_MAIN%>',
                        dataType: 'json',
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify({"token": localStorage.token, "api": "logout"}),
                        processData: false,
                        success: function (data, textStatus, jQxhr) {
                            localStorage.removeItem('token');
                            window.location = "index.jsp";
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                    e.preventDefault();
                }
                $('#logout').click(processForm);
            })(jQuery);
        </script>
    </body>
</html>

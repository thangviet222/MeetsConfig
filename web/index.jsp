<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="header">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LOGIN ADMIN</title>
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="templeteLogin/images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/select2/select2.min.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="templeteLogin/vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="templeteLogin/css/util.css">
        <link rel="stylesheet" type="text/css" href="templeteLogin/css/main.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

        <!--===============================================================================================-->
    </head>
    <body style="display: none">
        <script>
            (function ($) {
                $.holdReady(true);
                function processForm(e) {
                    if (localStorage.token == null)
                        return;
                    $.ajax({
                        url: '<%=constant.Constant.LOCAL_MAIN%>',
                        dataType: 'json',
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify({"token": localStorage.token, "api": "lst_role"}),
                        processData: false,
                        success: function (data, textStatus, jQxhr) {
                            if (data.code === 0) {
                                window.location = "main.jsp";
                            } else {
                                localStorage.clear();
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                }
                $('#header').before(processForm);
                $.holdReady(false);
            })(jQuery);
            $(window).load(function () {
                // When the page has loaded
                $("body").fadeIn(500);
            });
        </script>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100 p-t-50 p-b-90">
                    <form id="my-login" class="login100-form validate-form flex-sb flex-w" method="POST" >
                        <span class="login100-form-title p-b-51">
                            Login
                        </span>
                        <div class="wrap-input100 validate-input m-b-16" >
                            <input id="email" class="input100" type="text" name="email" placeholder="Username">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input m-b-16" >
                            <input id="pass" class="input100" type="password" name="pass" placeholder="Password">
                            <input id="passEncript" class="input100" type="hidden" >
                            <span class="focus-input100"></span>
                        </div>
                        <div class="flex-sb-m w-full p-t-3 p-b-24">
                            <div class="contact100-form-checkbox">
                                <h4 id="invalidLogin"></h4>
                            </div>
                        </div>
                        <div class="container-login100-form-btn m-t-17">
                            <button class="login100-form-btn">
                                Login
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/bootstrap/js/popper.js"></script>
        <script src="templeteLogin/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/daterangepicker/moment.min.js"></script>
        <script src="templeteLogin/vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="templeteLogin/js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>;
        <script type="text/javascript">
            (function ($) {
                function processForm(e) {
                    $.ajax({
                        url: '<%=constant.Constant.LOCAL_MAIN%>',
                        dataType: 'json',
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify({"email": $('#email').val(), "pwd": CryptoJS.MD5($('#pass').val()).toString(), "api": "login_admin"}),
                        processData: false,
                        success: function (data, textStatus, jQxhr) {
                            //                        $('#response pre').html(JSON.stringify(data));
                            if (data.code == 0) {
                                console.log(data.data.token);
                                window.localStorage.setItem("token", data.data.token.toString());
                                window.location = "main.jsp";
                            } else {
                                document.getElementById("invalidLogin").innerHTML = "Account or password incorrect";
                            }
                        },
                        error: function (jqXhr, textStatus, errorThrown) {
                            console.log(errorThrown);
                        }
                    });
                    e.preventDefault();
                }
                $('#my-login').submit(processForm);
            })(jQuery);

        </script>
    </body>
</html>

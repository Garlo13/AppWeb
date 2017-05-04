<%-- 
    Document   : login
    Created on : 03-abr-2017, 9:56:56
    Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
--%>

<%@page import="appweb.entity.DatosUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Boolean accedido = (Boolean) request.getAttribute("accedido");
    DatosUsuario usuario = (DatosUsuario) request.getAttribute("usuario");
%>
<html>

    <link href='style.css' rel='stylesheet' type='text/css'>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JobsNow</title>
        <!-- Latest compiled and minified CSS -->

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/40f6f1cf0c.js"></script>
    </head>
    <body>
        <%
            if (usuario == null && accedido != null && accedido) {
        %>
        <div class="middlePage" style="margin-top: 25px">
            <div class="alert alert-warning">
                <strong>Error:</strong> Usuario o contraseña incorrecto
            </div>
        </div>
        <%
            }
        %>
        <div class="middlePage">
            <div class="page-header">
                <h1 class="logo">JobsNow <small>Encuentra trabajo ya!</small></h1>

            </div>

            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Please Sign In</h3>
                </div>
                <div class="panel-body">

                    <div class="row">


                        <div class="col-md-5" >
                            <a class="btn btn-block btn-social btn-lg btn-twitter"><i class="fa fa-twitter"></i> Logueate con Twitter</a><br/>
                            <a class="btn btn-block btn-social btn-lg btn-github"><i class="fa fa-github"></i> Logueate con GitHub</a><br/>
                            <a class="btn btn-block btn-social btn-lg btn-facebook"><i class="fa fa-facebook"></i> Logueate con Facebook</a><br/>
                        </div>

                        <div class="col-md-7" style="border-left:1px solid #ccc;height:160px">
                            <form class="form-horizontal" action="ServletLogin" method="post">
                                <fieldset>
                                    <input id="email" name="email" type="text" placeholder="Enter User Name" class="form-control input-md">
                                    <div class="spacing"><input type="checkbox" name="checkboxes" id="checkboxes-0" value="1"><small> Recuerdame</small></div>
                                    <input id="password" name="password" type="password" placeholder="Enter Password" class="form-control input-md">
                                    <div class="spacing"><a href="#"><small>¿Has olvidado tu contraseña?</small></a><br/></div>
                                    <input type="submit" id="singlebutton" name="singlebutton" value="Sign In" class="btn btn-info btn-sm pull-right">
                                    <a href="registrar.jsp" target="_self"> <input type="button" name="boton" value="Registrar" class="btn btn-default btn-sm pull-left"/> </a>
                                </fieldset>
                            </form>
                        </div>

                    </div>

                </div>
            </div>

            <p>Sobre <a href="https://www.davidluque.xyz">eCorp</a></p>

        </div>
    </body>
</html>



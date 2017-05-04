<%-- 
    Document   : bandejapeticiones
    Created on : 26-abr-2017, 12:22:42
    Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
--%>

<%@page import="java.util.List"%>
<%@page import="appweb.entity.DatosUsuario"%>
<%
    DatosUsuario du = (DatosUsuario) session.getAttribute("usuario");
    List<DatosUsuario> listaPeticiones = (List)request.getAttribute("listaPeticiones");
    Boolean mensajeDisponible = (Boolean) request.getAttribute("mensajeDisponible");
    Integer peticiones = (Integer) request.getAttribute("peticiones");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Peticiones de amistad</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

        <!-- Icons -->
        <script src="https://use.fontawesome.com/0e798431ad.js"></script>

        <style>
            body {
                background: -webkit-linear-gradient(90deg, #16222A 10%, #3A6073 90%); /* Chrome 10+, Saf5.1+ */
                background:    -moz-linear-gradient(90deg, #16222A 10%, #3A6073 90%); /* FF3.6+ */
                background:     -ms-linear-gradient(90deg, #16222A 10%, #3A6073 90%); /* IE10 */
                background:      -o-linear-gradient(90deg, #16222A 10%, #3A6073 90%); /* Opera 11.10+ */
                background:         linear-gradient(90deg, #16222A 10%, #3A6073 90%); /* W3C */
                padding-top: 60px; /* ESTO LO PIDE LA PAGINA WEB DE BOOTSTRAP */
            }
            .jumbotron{
                margin: 1em;
                padding: 2em;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top  navbar-static-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="ServletListarDatos" style="margin-left:2em"><img src="https://img.clipartfest.com/6ce9d186fb2c7050f360764b2a087dda_big-image-png-job-clipart-png_2230-1803.png" style="height: 2em"></a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <form class="navbar-form navbar-left" action="ServletBuscar" method="POST">
                        <div class="form-group">
                            <input type="text" name="busqueda" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default fa fa-search"></button>
                    </form>
                    <ul class="nav navbar-nav navbar-right" style="margin-right: 1em;">
                        <%
                            if (mensajeDisponible != null && mensajeDisponible == true) {
                        %>
                        <li><a href="ServletListarCorreos"><i class="fa fa-envelope" style="color: orangered"></i></a></li>
                                <%
                                } else {
                                %>
                        <li><a href="ServletListarCorreos"><i class="fa fa-envelope"></i></a></li>
                                <%
                                    }
                                %>
                                <%
                                    if (peticiones != null && peticiones != 0) {
                                %>
                        <li><a href="ServletListarPeticiones"><i class="fa fa-users" style="color: orangered"></i></a></li>
                                <%} else {
                                %>
                        <li><a href="ServletListarPeticiones"><i class="fa fa-users"></i></a></li>
                                <%
                                    }
                                %>
                        <li><a href="ServletCerrarSesion"><i class="fa fa-sign-out"></i></a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="jumbotron vertical-center">
                <h3>Usuarios</h3>
                <div class="list-group">
                    <%
                        if (listaPeticiones != null) {
                            for (DatosUsuario usuario : listaPeticiones) {
                    %>
                    <div class="list-group-item">
                        <h4><%= usuario.getNombre()%>  <%= usuario.getApellidos()%>
                            <a href="ServletAceptarAmigo?id=<%= usuario.getIdUsuario()%>"><i class="glyphicon glyphicon-ok-circle" style="font-size: 25px; padding-left: 10px"></i></a>  
                            <a href="ServletRechazarAmigo?id=<%= usuario.getIdUsuario()%>"><i class="glyphicon glyphicon-remove-circle" style="font-size: 25px; padding-left: 10px"></i></a>
                        </h4>
                    </div>
                    <%
                        }
                        if (listaPeticiones.size() == 0) {
                    %>
                    <h4> No hay peticiones de amistad disponibles</h4>
                    <%
                            }
                        }
                    %>

                </div>
            </div>
        </div>
    </body>
</html>

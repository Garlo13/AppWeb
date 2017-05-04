<%-- 
    Document   : listarBusqueda
    Created on : 25-abr-2017, 15:30:35
    Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
--%>

<%@page import="appweb.entity.DatosUsuario"%>
<%@page import="java.util.List"%>
<%
    List<DatosUsuario> listaUsuarios = (List<DatosUsuario>) request.getAttribute("listaUsuariosPorNombre");
    List<DatosUsuario> listaAficion = (List<DatosUsuario>) request.getAttribute("listaUsuariosPorAficion");
    List<DatosUsuario> listaEstudios = (List<DatosUsuario>) request.getAttribute("listaUsuariosPorEstudios");
    List<DatosUsuario> listaExperiencia = (List<DatosUsuario>) request.getAttribute("listaUsuariosPorExperiencia");
    String busqueda = (String) request.getAttribute("busqueda");
    Integer peticiones = (Integer) request.getAttribute("peticiones");
    Boolean mensajeDisponible = (Boolean) request.getAttribute("mensajeDisponible");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            }
        </style>
        <script>
            jQuery(document).ready(function ($) {
                $(".clickable-row").click(function () {
                    window.location = $(this).data("href");
                });
            });
        </script>
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

                <%
                    if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                %>

                <h3>Usuarios cuyo nombre contiene: <%=busqueda%></h3>
                <div class="list-group">
                    <%
                        for (DatosUsuario usuario : listaUsuarios) {
                    %>
                    <a href="ServletListarDatos?id=<%= usuario.getIdUsuario()%>" class="list-group-item"><%=usuario.getNombre()%> <%=usuario.getApellidos()%></a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>


                <%
                    if (listaAficion != null && !listaAficion.isEmpty()) {
                %>
                <h3>Usuarios que son aficionados a: <%=busqueda%></h3>
                <div class="list-group">
                    <%
                        for (DatosUsuario usuario : listaAficion) {
                    %>
                    <a href="ServletListarDatos?id=<%= usuario.getIdUsuario()%>" class="list-group-item"><%=usuario.getNombre()%> <%=usuario.getApellidos()%></a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>

                <%
                    if (listaExperiencia != null && !listaExperiencia.isEmpty()) {
                %>
                <h3>Usuarios trabajan o han trabajo en: <%=busqueda%></h3>
                <div class="list-group">
                    <%
                        for (DatosUsuario usuario : listaExperiencia) {
                    %>
                    <a href="ServletListarDatos?id=<%= usuario.getIdUsuario()%>" class="list-group-item"><%=usuario.getNombre()%> <%=usuario.getApellidos()%></a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>

                <%
                    if (listaEstudios != null && !listaEstudios.isEmpty()) {
                %>
                <h3>Usuarios que estudian o han estudiado en: <%=busqueda%></h3>
                <div class="list-group">
                    <%
                        for (DatosUsuario usuario : listaEstudios) {
                    %>
                    <a href="ServletListarDatos?id=<%= usuario.getIdUsuario()%>" class="list-group-item"><%=usuario.getNombre()%> <%=usuario.getApellidos()%></a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>

<%-- 
    Document   : bandejaEntrada
    Created on : 22-abr-2017, 11:37:22
    Author     : david
--%>

<%@page import="appweb.entity.DatosUsuario"%>
<%@page import="java.util.List"%>
<%@page import="appweb.entity.Mensaje"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    List<Mensaje> listaMensajesAmigo = (List<Mensaje>) request.getAttribute("listaMensajesAmigo");
    DatosUsuario amigo = (DatosUsuario) request.getAttribute("amigo");
    DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");
    List<DatosUsuario> listaAmigos = (List<DatosUsuario>) request.getAttribute("listaAmigos");
%>
<html>
    <head>
        <!--
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        Latest compiled and minified JavaScript
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/40f6f1cf0c.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
        -->
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='style.css' rel='stylesheet' type='text/css'>
        <!-- Icons -->
        <script src="https://use.fontawesome.com/0e798431ad.js"></script>
        <title>Bandeja de Entrada</title>
        <style>
            body { padding-top: 70px; }
            .message-panel{
                background-color: #EEEEEE;
                width: 100%;
                padding: 2em;
            }
            .container{
                margin: 2em;
            }
            .msg{
                margin: 1em;
                font-weight: 500;
            }
            .msg-box{
                border-style: solid;
                border-width: 0.01px;
                margin: 1em;
                padding: 1.5em;
            }
            #friend{
                background-color: #FFFFFF;
            }
            #user{
                background-color: #DCF8C6;
            }
            .msg-text{
                color:#111111;
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
                    <a class="navbar-brand" href="ServletListarDatos">Brand</a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <form class="navbar-form navbar-left" action="ServletBuscar" method="POST">
                        <div class="form-group">
                            <input type="text" name="busqueda" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default fa fa-search"></button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="ServletListarCorreos"><i class="fa fa-envelope"></i></a></li>
                        <li><a href="ServletListarPeticiones"><i class="fa fa-users" style="color:green"></i></a></li>
                        <li><a href="ServletCerrarSesion">Cerrar Sesión</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="col-sm-4">
                <div class="list-group">
                    <%
                        if (listaAmigos != null) {
                            for (DatosUsuario amigos : listaAmigos) {
                    %>
                    <a href="ServletListarCorreos?amigo=<%= amigos.getIdUsuario()%>" class="list-group-item"><%=amigos.getNombre() + " " + amigos.getApellidos()%></a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="jumbotron" style="border-radius: 0px;">
                    <%
                        if (listaMensajesAmigo != null) {
                            for (Mensaje mensaje : listaMensajesAmigo) {
                                if (amigo.getEmail().equals(mensaje.getMensaje().substring(0, amigo.getEmail().length()))) {
                    %>
                    <div id="friend" class="msg-box">
                        <div class="msg">
                            <small class="pull-right time"><i class="fa fa-clock-o"></i><%=mensaje.getFecha()%></small>
                            <h4 class="media-heading"><%=amigo.getNombre() + " " + amigo.getApellidos()%></h4>
                            <small class="msg-text col-md-10 text-muted"><%=mensaje.getMensaje().substring(amigo.getEmail().length())%> </small>
                        </div>
                    </div>
                    <%
                    } else {
                    %>
                    <div id="user" class="msg-box">
                        <div class="msg">
                            <small class="pull-right time"><i class="fa fa-clock-o"></i><%=mensaje.getFecha()%></small>
                            <h4 class="media-heading"><%=usuario.getNombre() + " " + usuario.getApellidos()%></h4>
                            <small class="msg-text col-md-10 text-muted"><%=mensaje.getMensaje().substring(usuario.getEmail().length())%> </small>
                        </div>
                    </div>
                    <%
                                }
                            }
                        }
                    %>
                <form method="post" action="ServletEnviarMensaje">
                    <%
                        if (amigo != null) {
                    %>
                    <input type="hidden" name="id" value="<%=amigo.getIdUsuario()%>" />
                    <%
                        }
                    %>
                    <div class="send-wrap ">
                        <textarea name="mensaje" class="form-control send-message" rows="3" placeholder="Escribe un mensaje..."></textarea>
                    </div>
                    <div class="btn-panel">
                        <button class="btn btn-success" role="button">
                            <i class="fa fa-share"></i> Enviar mensaje
                        </button>
                    </div>
                </form>
                </div>
            </div>
    </body>
</html>

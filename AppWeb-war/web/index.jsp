<%-- 
    Document   : index
    Created on : 24-abr-2017, 19:06:45
    Author     : adri_
--%>

<%@page import="dropbox.DropboxController"%>
<%@page import="appweb.entity.Estudio"%>
<%@page import="appweb.entity.Aficion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="appweb.entity.Experiencia"%>
<%@page import="appweb.entity.DatosUsuario"%>
<%
    DatosUsuario usuario = (DatosUsuario) request.getAttribute("usuario");
    DatosUsuario usuarioLogueado = (DatosUsuario) session.getAttribute("usuario");
    List<Experiencia> listaExperiencias = (List<Experiencia>) request.getAttribute("listaExperiencias");
    List<Aficion> listaAficiones = (List<Aficion>) request.getAttribute("listaAficiones");
    List<Estudio> listaEstudios = (List<Estudio>) request.getAttribute("listaEstudios");
    Boolean sonAmigos = (Boolean) request.getAttribute("sonAmigos");
    Boolean peticionAmistad = (Boolean) request.getAttribute("peticionAmistad");
    Integer peticiones = (Integer) request.getAttribute("peticiones");
    Boolean mensajeDisponible = (Boolean) request.getAttribute("mensajeDisponible");
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= usuario.getNombre() + " " + usuario.getApellidos()%></title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

        <!-- Icons -->
        <script src="https://use.fontawesome.com/0e798431ad.js"></script>

        <style>
            /* Para el fondo del body */
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
            .btn{
                margin: 0.2em;
            }
            h1 { 
                color: #16222A;
                font-size: 2em; 
                font-weight: 800; 
                line-height: 72px; 
                margin: 0 0 24px;
                text-transform: uppercase; 
            }
            h3 { 
                color: #16222A;
                font-size: 2em; 
                font-weight: 600; 
                line-height: 72px;
                text-transform: uppercase; 
            }
            /* Codigo para los social links */
            .social-links a{
                text-align:center;
                float: left;
                width: 36px;
                height: 36px;
                border: 2px solid #909090;
                border-radius: 100%;
                margin-right: 7px; /*space between*/
                display: flex;
                align-items: flex-start;
                transition: all 0.4s;
                -webkit-transition: all 0.4s;
            } 
            .social-links a i{
                font-size: 20px;
                align-self:center;
                color: #909090;
                transition: all 0.4s;
                -webkit-transition: all 0.4s;
                margin: 0 auto;
            }
            .social-links a i::before{
                display:inline-block;
                text-decoration:none;
            }
            .social-links a:hover{
                background: rgba(0,0,0,0.2);
            }
            .social-links a:hover i{
                color:#fff;
            }
            .bgimg {
                padding: 2em;
                width: 100%;
                background-image: url('http://medioambiente.blogs.upv.es/files/2013/10/cabecera1.jpg');
                background-size: cover;
                margin: 0.1em;
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
                <div class="row bgimg">
                    <div class="col-sm-3 col-md-3">  
                        <img src="<%=DropboxController.getUrl(usuario.getFoto())%>" class="img-circle" alt="Cinque Terre" width="150" height="150">
                    </div>
                    <div class="col-sm-9 col-md-9">
                        <%                if (usuario.getNombre() != null || usuario.getApellidos() != null) {
                        %>
                        <h3><%= usuario.getNombre() + " " + usuario.getApellidos()%></h3>
                        <%
                            }
                        %>
                    </div>
                </div>
                <br/>

                <div class="row">
                    <div class="col-sm-3 col-md-3">
                        <div class="social-links">
                            <%
                                if (usuario.getTwitter() != null && !usuario.getTwitter().equals("")) {
                            %>
                            <a href="http://www.twitter.com/<%= usuario.getTwitter()%>" target="_blank"><i class="fa fa-twitter fa-lg"></i></a>
                                <%
                                    }
                                %>

                            <%
                                if (usuario.getInstagram() != null && !usuario.getInstagram().equals("")) {
                            %>
                            <a href="http://www.instagram.com/<%= usuario.getInstagram()%>" target="_blank"><i class="fa fa-instagram fa-lg"></i></a>
                                <%
                                    }
                                %>
                                <%
                                    if (usuario.getWeb() != null && !usuario.getWeb().equals("")) {
                                %>
                            <a href="http://<%= usuario.getWeb()%>"target="_blank"><i class="fa fa-link fa-lg"></i></a>
                                <%
                                    }
                                %>
                        </div>
                    </div>

                    <div class="col-sm-6 col-md-6">
                    </div>

                    <div class="co-sm-3 col-md-3">
                        <%
                            if (usuarioLogueado.getIdUsuario().equals(usuario.getIdUsuario())) {
                        %>
                        <a class="btn btn-success pull-right" href="ServletEditar"> Editar Perfil</a>
                        <%
                        } else if (!usuarioLogueado.getIdUsuario().equals(usuario.getIdUsuario()) && sonAmigos) {
                        %>
                        <a class="btn btn-info pull-right" href="ServletListarCorreos?amigo=<%= usuario.getIdUsuario()%>"> Enviar mensaje</a>
                        <%
                        } else if (!peticionAmistad) {
                        %>
                        <a class="btn btn-primary pull-right " href="ServletEnviarPeticion?id=<%= usuario.getIdUsuario()%>"> Añadir amigo</a>
                        <%
                        } else if (peticionAmistad) {
                            int rechazar = 1;
                        %>
                        <a class="btn btn-primary pull-right " href="ServletRechazarAmigo?id=<%= usuario.getIdUsuario()%>&rechazar=<%= rechazar%>"> Cancelar solicitud de amistad</a>
                        <%

                            }
                        %>
                    </div>
                </div>

                <h3>Experiencia</h3>
                <table class="table table-responsive">
                    <thead>
                        <tr>
                            <th>Fecha Comienza</th>
                            <th>Fecha Finalizaci&oacute;n</th>
                            <th>Empresa</th>
                            <th>Web Empresa</th>
                            <th>Puesto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaExperiencias != null && !listaExperiencias.isEmpty()) {
                                for (Experiencia experiencia : listaExperiencias) {
                        %>
                        <tr>
                            <td><%=experiencia.getFechaComienzo().toString()%></td>
                            <td><%=experiencia.getFechaFinalizacion().toString()%></td>
                            <td><%=experiencia.getEmpresa()%></td>
                            <td><%=experiencia.getWebEmpresa()%></td>
                            <td><%=experiencia.getPuesto()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>




                <h3>Aficiones</h3>
                <table class="table table-responsive">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaAficiones != null && !listaAficiones.isEmpty()) {
                                for (Aficion aficion : listaAficiones) {
                        %>
                        <tr>
                            <td><%=aficion.getNombre()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>

                <h3>Estudios</h3>
                <table class="table table-responsive">
                    <thead>
                        <tr>
                            <th>Fecha Comienzo</th>
                            <th>Fecha de Finalizaci&oacute;n</th>
                            <th>Descripci&oacute;n</th>
                            <th>Ubicaci&oacute;n</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listaEstudios != null && !listaEstudios.isEmpty()) {
                                for (Estudio estudio : listaEstudios) {
                        %>
                        <tr>
                            <td><%=estudio.getFechaComienzo()%></td>
                            <td><%=estudio.getFechaFinalizacion()%></td>
                            <td><%=estudio.getDescripcion()%></td>
                            <td><%=estudio.getUbicacion()%></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>

            </div>
        </div>
    </body>
</html>

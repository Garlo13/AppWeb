<%-- 
    Document   : registrar
    Created on : 21-abr-2017, 10:40:16
    Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="appweb.entity.Aficion"%>
<%@page import="appweb.entity.Experiencia"%>
<%@page import="appweb.entity.Estudio"%>
<%@page import="appweb.entity.DatosUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    DatosUsuario contacto = (DatosUsuario) request.getAttribute("usuario");
    List<Aficion> aficiones = (List<Aficion>) request.getAttribute("aficiones");
    List<Experiencia> experiencias = (List<Experiencia>) request.getAttribute("experiencias");
    List<Estudio> estudios = (List<Estudio>) request.getAttribute("estudios");
    String idEst = (String) request.getAttribute("idEstudio");
    String idExp = (String) request.getAttribute("idExperiencia");
    String idAfi = (String) request.getAttribute("idAficion");
    BigDecimal idEstudio = null;
    BigDecimal idExperiencia = null;
    BigDecimal idAficion = null;
    if (idEst != null) {
        idEstudio = new BigDecimal(idEst);
    }
    if (idExp != null) {
        idExperiencia = new BigDecimal(idExp);
    }
    if (idAfi != null) {
        idAficion = new BigDecimal(idAfi);
    }
    Boolean badPassword = (Boolean) request.getAttribute("badPassword");
    Boolean badPassword2 = (Boolean) request.getAttribute("badPassword2");
    Integer peticiones = (Integer) request.getAttribute("peticiones");
    Boolean mensajeDisponible = (Boolean) request.getAttribute("mensajeDisponible");
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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

        <style type="text/css">
            .bs-example{
                margin: 20px;
            }
        </style>
    </head>
    <body>

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
                        
        <div class="middlePage" style="margin-top:  3em; width: 700px">
            <div class="page-header">
                <h1 class="logo">JobsNow <small>Welcome to our place!</small></h1>

            </div>

            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Editar</h3>
                </div>
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-7" style="border-left:1px solid #ccc;height:auto; width: 680px">
                            <form class="form-horizontal" action="ServletGuardarDatos" method="post" enctype="multipart/form-data">
                                <fieldset>
                                    <div class="spacing"><small>Nombre</small></div>
                                    <%
                                        if (contacto.getNombre() != null) {
                                    %>
                                    <input id="nombre" name="nombre" type="text" placeholder="Nombre" class="form-control input-md" value="<%= contacto.getNombre()%>">

                                    <%
                                        }
                                    %>

                                    <div class="spacing"><small>Apellidos</small></div>
                                    <%
                                        if (contacto.getApellidos() != null) {
                                    %>
                                    <input id="apellidos" name="apellidos" type="text" placeholder="Apellidos" class="form-control input-md" value="<%=contacto.getApellidos()%>">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Email</small></div>
                                    <%
                                        if (contacto.getEmail() != null) {
                                    %>
                                    <input id="email" name="email" type="text" placeholder="Email" class="form-control input-md" value="<%=contacto.getEmail()%>">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Contraseña Actual</small></div>
                                    <%
                                        if (contacto.getPassword() != null) {
                                    %>
                                    <input id="password" name="password" type="password" placeholder="Contrasela actual" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>

                                    <%
                                        if (badPassword != null && badPassword) {
                                    %>   
                                    <p class="pull-right" style="color: red"><small>Contraseña actual no coincide</small></p>
                                    <%
                                        }
                                    %>

                                    <div class="spacing"><small>Nueva Contraseña</small></div>
                                    <input id="password2" name="password2" type="password" placeholder="Nueva contraseña" class="form-control input-md">
                                    <br/>
                                    <input id="password3" name="password3" type="password" placeholder="Repetir contraseña" class="form-control input-md">
                                    <%
                                        if (badPassword2 != null && badPassword2) {
                                    %>   
                                    <p class="pull-right" style="color: red"><small>Contraseña no coincide</small></p>
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Twitter</small></div>
                                    <%
                                        if (contacto.getTwitter() != null) {
                                    %>
                                    <input id="twitter" name="twitter" type="text" placeholder="@NombreUsuario" class="form-control input-md" value="<%=contacto.getTwitter()%>">
                                    <%
                                    } else {
                                    %>
                                    <input id="twitter" name="twitter" type="text" placeholder="@NombreUsuario" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Instagram</small></div>
                                    <%
                                        if (contacto.getInstagram() != null) {
                                    %>
                                    <input id="instagram" name="instagram" type="text" placeholder="@NombreUsuario" class="form-control input-md" value="<%=contacto.getInstagram()%>">
                                    <%
                                    } else {
                                    %>
                                    <input id="instagram" name="instagram" type="text" placeholder="@NombreUsuario" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Página Web</small></div>
                                    <%
                                        if (contacto.getWeb() != null) {
                                    %>
                                    <input id="paginaweb" name="paginaweb" type="text" placeholder="www.tuweb.com" class="form-control input-md" value="<%=contacto.getWeb()%>">
                                    <%
                                    } else {
                                    %>
                                    <input id="paginaweb" name="paginaweb" type="text" placeholder="www.tuweb.com" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Foto</small></div>
                                    <%
                                        if (contacto.getFoto() != null) {
                                    %>

                                    <input id="foto" name="foto" type="file" placeholder="Foto" class="form-control input-md" value="">
                                    <%
                                    } else {
                                    %>
                                    <input id="foto" name="foto" type="file" placeholder="Foto" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <br/>
                                    <button id="singlebutton" name="singlebutton" class="btn btn-info btn-sm pull-right" value="<%= contacto.getIdUsuario()%>">Guardar cambios</button>
                                    <form action="ServletListarDatos" style="margin-bottom: 10px;">
                                        <button id="singlebutton" name="singlebutton" class="btn btn-default btn-sm pull-left">Cancelar</button>                      
                                    </form><br/>
                                </fieldset>
                            </form>

                            <div class="spacing"><small>Estudios</small></div>
                            <table class="table table-striped">
                                <thead>

                                <tbody>
                                    <%
                                        if (estudios != null) {
                                    %>
                                    <tr>
                                        <th style="width:150px;">Comienzo</th>
                                        <th style="width:150px;">Finalizacion</th>
                                        <th style="width:150px;">Descripcion</th>  
                                        <th style="width:150px;">Ubicacion</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Estudio estudio : estudios) {
                                            if (idEstudio != null && idEstudio.equals(estudio.getIdEstudio())) {
                                    %>
                                <form action="ServletCrearActualizarEstudio?idEstudio=<%= estudio.getIdEstudio()%>" method="post">
                                    <tr>
                                        <td style="width:150px;"><input type="date" name="fechaComienzo" value="<%=estudio.getFechaComienzoString()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="date" name="fechaFin" value="<%=estudio.getFechaFinString()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" name="descripcion" value="<%=estudio.getDescripcion()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" name="ubicacion" value="<%=estudio.getUbicacion()%>" style="width:120px;"></td>  
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span></button></td>
                                        <td><a href="ServletBorrarEstudio?idEstudio=<%= estudio.getIdEstudio()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                    </tr>
                                </form>
                                <%
                                } else {
                                %>
                                <tr>
                                    <td style="width:150px;"><%=estudio.getFechaComienzo()%></td>
                                    <td style="width:150px;"><%=estudio.getFechaFinalizacion()%></td>
                                    <td style="width:150px;"><%=estudio.getDescripcion()%></td>
                                    <td style="width:150px;"><%=estudio.getUbicacion()%></td>  
                                    <td ><a href="ServletEditar?idEstudio=<%= estudio.getIdEstudio()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td> 
                                    <td><a href="ServletBorrarEstudio?idEstudio=<%= estudio.getIdEstudio()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                </tr>
                                <%
                                            }
                                        }
                                    }
                                %>
                                <form action="ServletCrearActualizarEstudio" method="post">
                                    <tr>
                                        <td style="width:150px;"><input type="date" name="fechaComienzo" style="width:120px;" required="true"></td>
                                        <td style="width:150px;"><input type="date" name="fechaFin" style="width:120px;" required="true"></td>
                                        <td style="width:150px;"><input type="text" name="descripcion" style="width:120px;" required="true"></td>
                                        <td style="width:150px;"><input type="text" name="ubicacion" style="width:120px;" required="true"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></td>
                                    </tr>
                                </form>
                                </tbody>
                            </table>
                            <div class="spacing" style="margin-top: 1em;">Experiencia</div>
                            <table class="table table-striped">
                                <thead>

                                <tbody>
                                    <%
                                        if (experiencias != null) {
                                    %>
                                    <tr>
                                        <th style="width:100px;">Comienzo</th>
                                        <th style="width:100px;">Finalizacion</th>
                                        <th style="width:100px;">Empresa</th>
                                        <th style="width:100px;">Web Empresa</th>  
                                        <th style="width:100px;">Puesto</th>
                                    </tr>
                                    </thead>
                                    <%
                                        for (Experiencia experiencia : experiencias) {
                                            if (idExperiencia != null && idExperiencia.equals(experiencia.getIdExperiencia())) {
                                    %>
                                    <form action="ServletCrearActualizarExperiencia?idExperiencia=<%=experiencia.getIdExperiencia()%>" method="post">
                                    <tr>
                                        <td style="width:100px;"><input type="date" name="fechaComienzo" value="<%=experiencia.getFechaComienzoString()%>" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="date" name="fechaFin" value="<%=experiencia.getFechaFinalizacionString()%>" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" name="empresa" value="<%=experiencia.getEmpresa()%>" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" name="webEmpresa" value="<%=experiencia.getWebEmpresa()%>" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" name="puesto" value="<%=experiencia.getPuesto()%>" style="width:100px;"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span></button></td>
                                        <td><a href="ServletBorrarExperiencia?idExperiencia=<%= experiencia.getIdExperiencia()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                    </tr>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <tr>
                                        <td style="width:100px;"><%=experiencia.getFechaComienzo()%></td>
                                        <td style="width:100px;"><%=experiencia.getFechaFinalizacion()%></td>
                                        <td style="width:100px;"><%=experiencia.getEmpresa()%></td>
                                        <td style="width:100px;"><%=experiencia.getWebEmpresa()%></td>
                                        <td style="width:100px;"><%=experiencia.getPuesto()%></td>
                                        <td><a href="ServletEditar?idExperiencia=<%= experiencia.getIdExperiencia()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                        <td><a href="ServletBorrarExperiencia?idExperiencia=<%= experiencia.getIdExperiencia()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                    </tr>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                <form action="ServletCrearActualizarExperiencia" method="post">
                                    <tr>
                                        <td style="width:100px;"><input type="date" name="fechaComienzo" style="width:100px;" required="true"></td>
                                        <td style="width:100px;"><input type="date" name="fechaFin" style="width:100px;" required="true"></td>
                                        <td style="width:100px;"><input type="text" name="empresa" style="width:100px;" required="true"></td>
                                        <td style="width:100px;"><input type="text" name="webEmpresa" style="width:100px;" required="true"></td>
                                        <td style="width:100px;"><input type="text" name="puesto" style="width:100px;" required="true"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></td>
                                    </tr>
                                </form>
                                </tbody>
                            </table>

                            <div class="spacing"><small>Aficiones</small></div>
                            <table class="table table-striped">
                                <thead>
                                    <%
                                        if (aficiones != null) {
                                    %>
                                    <tr>
                                        <th style="width:150px;">Nombre</th>
                                        <th style="width:150px;"> </th>
                                        <th style="width:150px;"> </th>
                                        <th style="width:150px;"> </th>

                                    </tr>
                                    </form>
                                </thead>
                                <%
                                    for (Aficion aficion : aficiones) {
                                        if (idAficion != null && idAficion.equals(aficion.getIdAficion())) {
                                %>
                                <tbody >
                                    <form action="ServletCrearActualizarAficion?idAficion=<%=aficion.getIdAficion()%>" method="post">
                                    <tr >
                                        <td style="width:150px;"><input type="text" name="nombreAficion" value="<%=aficion.getNombre()%>" style="width:120px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-ok"></span></button></td>
                                        <td><a href="ServletBorrarAficion?idAficion=<%= aficion.getIdAficion()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td>
                                    </tr>
                                    </form>
                                    <%
                                    } else {
                                    %>
                                    <tr >
                                        <td style="width:150px;"><%= aficion.getNombre()%></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td><a href="ServletEditar?idAficion=<%= aficion.getIdAficion()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                        <td><a href="ServletBorrarAficion?idAficion=<%= aficion.getIdAficion()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td>
                                    </tr>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                <form action="ServletCrearActualizarAficion" method="post">
                                    <tr>
                                        <td style="width:150px;"><input type="text" name="nombreAficion" style="width:100px;" required="true"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></td>
                                    </tr>
                                </form>
                                </tbody>
                            </table>
                            <div class="spacing"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
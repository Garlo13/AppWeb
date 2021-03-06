<%-- 
    Document   : registrar
    Created on : 21-abr-2017, 10:40:16
    Author     : david?
--%>

<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@page import="appweb.entity.Aficion"%>
<%@page import="appweb.entity.Experiencia"%>
<%@page import="appweb.entity.Estudio"%>
<%@page import="appweb.entity.Datosusuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Datosusuario contacto = (Datosusuario) request.getAttribute("usuario");
    List<Aficion> aficiones = (List<Aficion>) request.getAttribute("aficiones");
    List<Experiencia> experiencias = (List<Experiencia>) request.getAttribute("experiencias");
    List<Estudio> estudios = (List<Estudio>) request.getAttribute("estudios");
    String idEst = (String) request.getAttribute("id");
    BigDecimal idEstudio = null;
    if (idEst != null) {
        idEstudio = new BigDecimal(idEst);
    }
    Boolean badPassword = (Boolean) request.getAttribute("badPassword");
    Boolean badPassword2 = (Boolean) request.getAttribute("badPassword2");
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
                        <li><a href="bandejaentrada.jsp"><i class="fa fa-envelope"></i></a></li>
                        <!-- HAY QUE HACER UN IF EN EL COLOR PARA QUE SE PONGA DE COLOR CUANDO HAYA PETICIONES -->
                        <li><a href="ServletListarPeticiones"><i class="fa fa-users" style="color:green"></i></a></li>
                        <li><a href="ServletCerrarSesion">Cerrar Sesión</a></li>
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
                            <form class="form-horizontal" action="ServletGuardarDatos" method="post">
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
                                        if(badPassword!= null && badPassword){
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
                                        if(badPassword2!= null && badPassword2){
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
                                        }else{
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
                                        }else{
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
                                        }else{
                                    %>
                                    <input id="paginaweb" name="paginaweb" type="text" placeholder="www.tuweb.com" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Foto</small></div>
                                    <%
                                        if (contacto.getFoto() != null) {
                                    %>

                                    <input id="imagen" name="nombre" type="file" placeholder="Foto" class="form-control input-md" value="<%=contacto.getFoto()%>">
                                    <%
                                        }else{
                                    %>
                                    <input id="imagen" name="nombre" type="file" placeholder="Foto" class="form-control input-md" value="">
                                    <%
                                        }
                                    %>
                                    <br/>
                                    <button id="singlebutton" name="singlebutton" class="btn btn-info btn-sm pull-right" value="<%= contacto.getId()%>">Guardar cambios</button>
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
                                            if (idEstudio != null && idEstudio.equals(estudio.getIdEstudios())) {
                                    %>
                                <form action="ServletInsertEstudio" method="post">
                                    <tr>
                                        <td style="width:150px;"><input type="date" value="<%=estudio.getFechaComienzoString()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="date" value="<%=estudio.getFechaFinString()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" value="<%=estudio.getDescripcion()%>" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" value="<%=estudio.getUbicacion()%>" style="width:120px;"></td>  
                                        <td ><a href="/editar.jsp?id=<%= estudio.getIdEstudios()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                        <td><a href="ServletBorrarEstudio?id=<%= estudio.getIdEstudios()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                    </tr>
                                </form>
                                <%
                                } else {
                                %>
                                <tr>
                                    <td style="width:150px;"><%=estudio.getFechaComienzo()%></td>
                                    <td style="width:150px;"><%=estudio.getFechoFinalizacion()%></td>
                                    <td style="width:150px;"><%=estudio.getDescripcion()%></td>
                                    <td style="width:150px;"><%=estudio.getUbicacion()%></td>  
                                    <td ><a href="ServletEditar?id=<%= estudio.getIdEstudios()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                    <td><a href="ServletBorrarEstudio?id=<%= estudio.getIdEstudios()%>"><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                </tr>
                                <%
                                            }
                                        }
                                    }
                                %>
                                <form action="ServletInsertEstudio" method="post">
                                    <tr>
                                        <td style="width:150px;"><input type="date" name="fechaComienzo" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="date" name="fechaFin" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" name="descripcion" style="width:120px;"></td>
                                        <td style="width:150px;"><input type="text" name="ubicacion" style="width:120px;"></td>
                                        <td ><button type="submit" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></td>
                                    </tr>
                                </form>
                                </tbody>
                            </table>
                            <div class="spacing"><small>Experiencia</small></div>
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
                                    %>
                                    <tr>
                                        <td style="width:100px;"><%=experiencia.getFechaComienzo()%></td>
                                        <td style="width:100px;"><%=experiencia.getFechaFinalizacion()%></td>
                                        <td style="width:100px;"><%=experiencia.getEmpresa()%></td>
                                        <td style="width:100px;"><%=experiencia.getWebEmpresa()%></td>
                                        <td style="width:100px;"><%=experiencia.getPuesto()%></td>
                                        <td><a href="ServletEditarExperiencia?id="><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                        <td><a href="ServletBorrarExperiencia?id="><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td> 
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    <tr>
                                        <td style="width:100px;"><input type="date" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="date" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" style="width:100px;"></td>
                                        <td style="width:100px;"><input type="text" style="width:100px;"></td>
                                        <td ><a href=""><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></a></td>
                                    </tr>
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
                                </thead>
                                <%
                                    for (Aficion aficion
                                            : aficiones) {
                                %>


                                <tbody >
                                    <tr >
                                        <td style="width:150px;"><%= aficion.getNombre()%></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td><a href="ServletEditarAficion?id="><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></button></a></td>
                                        <td><a href="ServletBorrarAficion?id="><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-remove"></span></button></a></td>
                                    </tr>
                                    <%
                                            }
                                        }
                                    %>
                                    <tr>
                                        <td style="width:150px;"><input type="text" style="width:100px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td style="width:150px;"></td>
                                        <td ><a href=""><button type="button" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-plus"></span></button></a></td>
                                    </tr>
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
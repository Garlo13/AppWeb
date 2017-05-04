<%-- 
    Document   : registrar
    Created on : 21-abr-2017, 10:40:16
    Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Boolean emailusado = (Boolean) request.getAttribute("emailusado");
    Boolean pass = (Boolean) request.getAttribute("pass");
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
        <div class="middlePage" style="margin-top:  0;">
            <div class="page-header">
                <h1 class="logo">JobsNow <small>Welcome to our place!</small></h1>

            </div>

            <div class="panel panel-info">
                <div class="panel-heading">
                    <h3 class="panel-title">Registrate</h3>
                </div>
                <div class="panel-body">

                    <div class="row">
                        <div class="col-md-7" style="border-left:1px solid #ccc;<% 
                            if(emailusado!=null && emailusado || pass != null && pass){ 
                                %>
                                height:715px">
                                <%  }else{
                                    %>
                                    height:660px">
                                    <% 
                                    }
                                %>
                            <form class="form-horizontal" action="ServletRegistrar" method="post" enctype="multipart/form-data">
                                <fieldset>
                                    <div class="spacing"><small>Nombre</small></div>
                                    <input id="nombre" name="nombre" type="text" placeholder="Nombre" class="form-control input-md" required="true">
                                    <div class="spacing"><small>Apellidos</small></div>
                                    <input id="apellidos" name="apellidos" type="text" placeholder="Apellidos" class="form-control input-md" required="true">
                                    <div class="spacing"><small>Email</small></div>
                                    <input id="email" name="email" type="text" placeholder="Email" class="form-control input-md" required="true">
                                     <%
                                        if(emailusado!=null && emailusado){
                                    %>   
                                    <p class="pull-right" style="color: red; font-weight: 600"><small>Email ya esta en uso</small></p>
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Contraseña</small></div>
                                    
                                    <input id="password" name="password" type="password" placeholder="Password" class="form-control input-md" required="true">
                                    <div class="spacing"><small>Repetir Contraseña</small></div>
                                    <input id="password2" name="password2" type="password" placeholder="Password" class="form-control input-md" required="true">
                                    <%
                                        if(pass !=null && pass){
                                    %>   
                                    <p class="pull-right" style="color: red; font-weight: 600"><small>Contraseña no coincide</small></p>
                                    <%
                                        }
                                    %>
                                    <div class="spacing"><small>Twitter</small></div>
                                    <input id="twitter" name="twitter" type="text" placeholder="@NombreUsuario" class="form-control input-md">
                                    <div class="spacing"><small>Instagram</small></div>
                                    <input id="instagram" name="instagram" type="text" placeholder="@NombreUsuario" class="form-control input-md">
                                    <div class="spacing"><small>Página Web</small></div>
                                    <input id="web" name="web" type="text" placeholder="www.tuweb.com" class="form-control input-md">
                                    <div class="spacing"><small>Foto</small></div>
                                    <input id="foto" name="foto" type="file" placeholder="Foto" class="form-control input-md">
                                    <div class="spacing"></div>
                                    <button id="singlebutton" name="singlebutton" class="btn btn-info btn-sm pull-right">Registrarse</button>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

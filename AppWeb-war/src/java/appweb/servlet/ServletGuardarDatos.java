/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.servlet;

import appweb.ejb.DatosUsuarioFacade;
import appweb.entity.Aficion;
import appweb.entity.DatosUsuario;
import appweb.entity.Estudio;
import appweb.entity.Experiencia;
import dropbox.DropboxController;
import dropbox.DropboxControllerException;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author adri_
 */
@WebServlet(name = "ServletGuardarDatos", urlPatterns = {"/ServletGuardarDatos"})
@MultipartConfig
public class ServletGuardarDatos extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosusuariofacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");//OJO!!

        Boolean badPassword = false;
        Boolean badPassword2 = false;
        //siempre que haya algun cambio, hay que actualizar la sesion tambien.
        DatosUsuario usuario;

        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");
        String password3 = request.getParameter("password3");
        String twitter = request.getParameter("twitter");
        String instagram = request.getParameter("instagram");
        String paginaweb = request.getParameter("paginaweb");

        String foto = request.getParameter("foto");//serializable??

        //----------Codigo para obtención de la foto---------------------------- 
        Part filePart = request.getPart("foto"); // Retrieves <input type="file" name="file">
        //----------------------------------------------------------------------
        HttpSession session;
        session = request.getSession();
        DatosUsuario usuarioSesion = (DatosUsuario) session.getAttribute("usuario");
        BigDecimal id = usuarioSesion.getIdUsuario();

        usuario = this.datosusuariofacade.find(id);

        List<Aficion> aficiones = (List<Aficion>) usuario.getAficionCollection();
        List<Experiencia> experiencias = (List<Experiencia>) usuario.getExperienciaCollection();
        List<Estudio> estudios = (List<Estudio>) usuario.getEstudioCollection();

        usuario.setNombre(nombre);
        usuario.setApellidos(apellidos);
        usuario.setEmail(email);

        if (password2 != null && !password2.isEmpty() && password != null && !password.isEmpty()) {
            if (password.equals(usuario.getPassword())) {
                if (password2.equals(password3)) {
                    usuario.setPassword(password2);
                } else {
                    badPassword2 = true;
                }

            } else {
                usuario.setPassword(usuario.getPassword());
                badPassword = true;
            }
        } else {
            usuario.setPassword(usuario.getPassword());
        }

        usuario.setTwitter(twitter);
        usuario.setInstagram(instagram);
        usuario.setWeb(paginaweb);

        String nombreFoto = "";
        if (foto == null) {
            nombreFoto = usuario.getEmail() + ".jpg";
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            InputStream fileContent = filePart.getInputStream();
            DropboxController.overwriteFile(nombreFoto, fileContent);

        } else {
            nombreFoto = "default.jpg";
        }
        usuarioSesion.setFoto(nombreFoto);

        this.datosusuariofacade.edit(usuario);//actualiza el usuario

        session.setAttribute("usuario", usuario);//actualizamos la sesion

        RequestDispatcher rd;

        if (badPassword || badPassword2) {
            request.setAttribute("usuario", usuario);
            request.setAttribute("aficiones", aficiones);
            request.setAttribute("experiencias", experiencias);
            request.setAttribute("estudios", estudios);
            request.setAttribute("badPassword", badPassword);
            request.setAttribute("badPassword2", badPassword2);

            rd = this.getServletContext().getRequestDispatcher("/editar.jsp");
            rd.forward(request, response);
        } else {
            rd = this.getServletContext().getRequestDispatcher("/ServletListarDatos");
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

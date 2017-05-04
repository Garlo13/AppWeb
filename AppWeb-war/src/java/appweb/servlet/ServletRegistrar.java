/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.servlet;

import appweb.ejb.DatosUsuarioFacade;
import appweb.entity.DatosUsuario;
import dropbox.DropboxController;
import dropbox.DropboxControllerException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
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
import javax.servlet.http.Part;

/**
 *
 * @author Daniel
 */
@WebServlet(name = "ServletRegistrar", urlPatterns = {"/ServletRegistrar"})
@MultipartConfig
public class ServletRegistrar extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosusuarioFacade;

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
        DatosUsuario datosUsuario;

        String nombre = request.getParameter("nombre");//obligatorio
        String apellidos = request.getParameter("apellidos");//obligatorio
        String email = request.getParameter("email");//obligatorio
        String password = request.getParameter("password");//obligatorio
        String password2 = request.getParameter("password2");//obligatorio
        String twitter = request.getParameter("twitter");
        String instagram = request.getParameter("instagram");
        String web = request.getParameter("web");
        String foto = request.getParameter("foto");//serializable??

        //----------Codigo para obtención de la foto---------------------------- 
        Part filePart = request.getPart("foto"); // Retrieves <input type="file" name="file">
        //----------------------------------------------------------------------

        if (this.datosusuarioFacade.emailUsado(email)) {
            Boolean emailusado = true;
            request.setAttribute("emailusado", emailusado);
        }
        if (!password.equals(password2)) {
            Boolean pass = true;
            request.setAttribute("pass", pass);
        }
        if (this.datosusuarioFacade.emailUsado(email) || !password.equals(password2)) {
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/registrar.jsp");
            rd.forward(request, response);
        } else {

            datosUsuario = this.datosusuarioFacade.crearUsuario(email, password, nombre, apellidos);

            if (twitter != null) {
                datosUsuario.setTwitter(twitter);
            }
            if (instagram != null) {
                datosUsuario.setInstagram(instagram);
            }
            if (web != null) {
                datosUsuario.setWeb(web);
            }
            String nombreFoto = "";
            if (foto == null) {
                nombreFoto = email + ".jpg";
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
                InputStream fileContent = filePart.getInputStream();
                try {
                    DropboxController.uploadFile(nombreFoto, fileContent);
                } catch (DropboxControllerException ex) {
                    Logger.getLogger(ServletRegistrar.class.getName()).log(Level.SEVERE, null, ex);
                }

            } else {
                nombreFoto = "default.jpg";
            }
            datosUsuario.setFoto(nombreFoto);
            

            this.datosusuarioFacade.create(datosUsuario);

            // RequestDispatcher rd;
            // rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            // rd.forward(request, response);
            response.sendRedirect("login.jsp");
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

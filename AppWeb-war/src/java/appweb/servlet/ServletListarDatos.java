/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.servlet;

import appweb.ejb.DatosUsuarioFacade;
import appweb.ejb.MensajeFacade;
import appweb.entity.DatosUsuario;
import appweb.entity.Mensaje;
import java.io.IOException;
import java.math.BigDecimal;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Adrián
 */
@WebServlet(name = "ServletListarDatos", urlPatterns = {"/ServletListarDatos"})
public class ServletListarDatos extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosUsuarioFacade;
    
    @EJB
    private MensajeFacade mensajeFacade;

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

        HttpSession session = request.getSession();

        String stringId = request.getParameter("id");
        if (stringId == null || stringId.isEmpty()) {
            stringId = (String) session.getAttribute("id");
            session.removeAttribute("id");
        }
        DatosUsuario miusuario = (DatosUsuario) session.getAttribute("usuario");
        miusuario = this.datosUsuarioFacade.find(miusuario.getIdUsuario());
        session.setAttribute("usuario", miusuario);
        DatosUsuario usuario = null;
        
        for(Mensaje mensaje : miusuario.getMensajeCollection()){
            if (!mensaje.getMensaje().startsWith(miusuario.getEmail()) && mensaje.getLeido()=='0') {
                    request.setAttribute("mensajeDisponible", true);
                }
        }
        
        if (stringId == null || stringId.isEmpty()) {
            usuario = (DatosUsuario) session.getAttribute("usuario");
        } else {
            usuario = this.datosUsuarioFacade.find(new BigDecimal(stringId));
            request.setAttribute("sonAmigos", miusuario.getMisAmigos().contains(usuario));
            request.setAttribute("peticionAmistad", miusuario.getPeticionesEnviadas().contains(usuario));
        }
        request.setAttribute("peticiones", miusuario.getPeticionesRecibidas().size());
        request.setAttribute("usuario", usuario);
        request.setAttribute("listaExperiencias", usuario.getExperienciaCollection());
        request.setAttribute("listaAficiones", usuario.getAficionCollection());
        request.setAttribute("listaEstudios", usuario.getEstudioCollection());

        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/index.jsp");
        rd.forward(request, response);
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

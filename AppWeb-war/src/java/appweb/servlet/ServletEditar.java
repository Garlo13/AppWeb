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
import appweb.entity.Mensaje;
import java.io.IOException;
import java.util.List;
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
 * @author Daniel
 */
@WebServlet(name = "ServletEditar", urlPatterns = {"/ServletEditar"})
public class ServletEditar extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosUsuarioFacade;

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();

        DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");
        usuario = this.datosUsuarioFacade.find(usuario.getIdUsuario());
        session.setAttribute("usuario", usuario);
        String idEstudio = (String) request.getParameter("idEstudio");
        String idExperiencia = (String) request.getParameter("idExperiencia");
        String idAficion = (String) request.getParameter("idAficion");
        
        List<Aficion> aficiones = (List<Aficion>) usuario.getAficionCollection();
        List<Experiencia> experiencias = (List<Experiencia>) usuario.getExperienciaCollection();
        List<Estudio> estudios = (List<Estudio>) usuario.getEstudioCollection();
        
        for(Mensaje mensaje : usuario.getMensajeCollection()){
            if (!mensaje.getMensaje().startsWith(usuario.getEmail()) && mensaje.getLeido()=='0') {
                    request.setAttribute("mensajeDisponible", true);
                }
        }
        
        request.setAttribute("usuario",usuario);
        request.setAttribute("aficiones", aficiones);
        request.setAttribute("experiencias", experiencias);
        request.setAttribute("estudios", estudios);
        request.setAttribute("idEstudio", idEstudio);
        request.setAttribute("idExperiencia", idExperiencia);
        request.setAttribute("idAficion", idAficion);
        request.setAttribute("peticiones", usuario.getPeticionesRecibidas().size());
        RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/editar.jsp");
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

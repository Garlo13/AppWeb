package appweb.servlet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */

import appweb.ejb.DatosUsuarioFacade;
import appweb.entity.DatosUsuario;
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
 * @author Adrián
 */
@WebServlet(urlPatterns = {"/ServletBuscar"})
public class ServletBuscar extends HttpServlet {

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
        
        HttpSession session = request.getSession();

        DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");
        usuario = this.datosUsuarioFacade.find(usuario.getIdUsuario());
        session.setAttribute("usuario", usuario);
        
        List<DatosUsuario> listaUsuariosPorNombre;
        List<DatosUsuario> listaUsuariosPorAficion;
        List<DatosUsuario> listaUsuariosPorEstudios;
        List<DatosUsuario> listaUsuariosPorExperiencia;
        
        String busqueda = request.getParameter("busqueda");
        
        listaUsuariosPorNombre = this.datosUsuarioFacade.findByName(busqueda, usuario.getIdUsuario());
        listaUsuariosPorAficion = this.datosUsuarioFacade.findByAficion(busqueda, usuario.getIdUsuario());
        listaUsuariosPorEstudios = this.datosUsuarioFacade.findByEstudios(busqueda, usuario.getIdUsuario());
        listaUsuariosPorExperiencia = this.datosUsuarioFacade.findByExperiencia(busqueda, usuario.getIdUsuario());
        
        for(Mensaje mensaje : usuario.getMensajeCollection()){
            if (!mensaje.getMensaje().startsWith(usuario.getEmail()) && mensaje.getLeido()=='0') {
                    request.setAttribute("mensajeDisponible", true);
                }
        }
        
        request.setAttribute("peticiones", usuario.getPeticionesRecibidas().size());
        request.setAttribute("listaUsuariosPorNombre", listaUsuariosPorNombre);
        request.setAttribute("listaUsuariosPorAficion", listaUsuariosPorAficion);
        request.setAttribute("listaUsuariosPorEstudios", listaUsuariosPorEstudios);
        request.setAttribute("listaUsuariosPorExperiencia", listaUsuariosPorExperiencia);
        request.setAttribute("busqueda", busqueda);
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/listarBusqueda.jsp");
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

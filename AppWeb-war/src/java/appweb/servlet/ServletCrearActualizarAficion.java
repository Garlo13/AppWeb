/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.servlet;

import appweb.ejb.AficionFacade;
import appweb.ejb.DatosUsuarioFacade;
import appweb.entity.Aficion;
import appweb.entity.DatosUsuario;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import javax.ejb.EJB;
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
@WebServlet(name = "ServletCrearActualizarAficion", urlPatterns = {"/ServletCrearActualizarAficion"})
public class ServletCrearActualizarAficion extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosUsuarioFacade;

    @EJB
    private AficionFacade aficionFacade;
    
    
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
        DatosUsuario usuarioEnSession = (DatosUsuario) session.getAttribute("usuario");
        //-------Obteniendo valores del request---------------------------------
        String idAficion = (String) request.getParameter("idAficion");
        String nombreAficion = request.getParameter("nombreAficion");
        
        Aficion aficion;
        if (idAficion != null) { //Actualizar datos
            aficion = this.aficionFacade.find(new BigDecimal(idAficion));
            List<Aficion> listaAficion = (List<Aficion>) usuarioEnSession.getAficionCollection();
            int i = listaAficion.indexOf(aficion);
            aficion.setNombre(nombreAficion);
            
            listaAficion.set(i, aficion);
            
            usuarioEnSession.setAficionCollection(listaAficion);
            session.setAttribute("usuario", usuarioEnSession);
            this.aficionFacade.edit(aficion);
        } else {
            //------Creacion del aficion-------
            aficion = this.aficionFacade.crearAficion(nombreAficion);
            aficion.setDatosUsuarioIdUsuario(usuarioEnSession);
            
            //--------------------------------------------
            this.aficionFacade.create(aficion);
            //------Actualizacion usuario-------------------------------------------
            List<Aficion> listaDeAficion = (List<Aficion>) usuarioEnSession.getAficionCollection();
            listaDeAficion.add(aficion);
            usuarioEnSession.setAficionCollection(listaDeAficion);
            session.setAttribute("usuario", usuarioEnSession);
            this.datosUsuarioFacade.edit(usuarioEnSession);
        }
        

        //------Finalizamos el servlet------------------------------------------
        /*
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/editar.jsp");
        rd.forward(request, response);
         */
        response.sendRedirect("ServletEditar");
        
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

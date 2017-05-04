/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin
 */
package appweb.servlet;

import appweb.ejb.DatosUsuarioFacade;
import appweb.entity.DatosUsuario;
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
 * @author adri_
 */
@WebServlet(name = "ServletAceptarAmigo", urlPatterns = {"/ServletAceptarAmigo"})
public class ServletAceptarAmigo extends HttpServlet {

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
        
        String id = request.getParameter("id");
        
        DatosUsuario usuario = (DatosUsuario)session.getAttribute("usuario");
        DatosUsuario nuevoAmigo = this.datosUsuarioFacade.find(new BigDecimal(id));
                
        usuario.getMisAmigos().add(nuevoAmigo);
        nuevoAmigo.getSoyAmigoDe().add(usuario);
        usuario.getSoyAmigoDe().add(nuevoAmigo);
        nuevoAmigo.getMisAmigos().add(usuario);
        
        usuario.getPeticionesRecibidas().remove(nuevoAmigo);
        nuevoAmigo.getPeticionesEnviadas().remove(usuario);
        
        
        this.datosUsuarioFacade.edit(usuario);
        this.datosUsuarioFacade.edit(nuevoAmigo);
        
        session.setAttribute("usuario", usuario);
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/ServletListarPeticiones");
        rd.forward(request,response);
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

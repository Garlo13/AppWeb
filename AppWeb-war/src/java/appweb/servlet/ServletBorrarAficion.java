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
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Collection;
import javax.ejb.EJB;
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
@WebServlet(name = "ServletBorrarAficion", urlPatterns = {"/ServletBorrarAficion"})
public class ServletBorrarAficion extends HttpServlet {

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
        Aficion aficion;
        String aficionID;
        aficionID = request.getParameter("idAficion");
        aficion = this.aficionFacade.find(new BigDecimal(aficionID));
        HttpSession session = request.getSession();
        DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");
        Collection c = usuario.getAficionCollection();
        c.remove(aficion);
        usuario.setAficionCollection(c);
        this.aficionFacade.remove(aficion);
        this.datosUsuarioFacade.edit(usuario);
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

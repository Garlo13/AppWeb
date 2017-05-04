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
import java.io.PrintWriter;
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
 * @author johncarlo
 */
@WebServlet(name = "ServletEnviarMensaje", urlPatterns = {"/ServletEnviarMensaje"})
public class ServletEnviarMensaje extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");

        String texto = request.getParameter("mensaje");
        String stringId = request.getParameter("id");
        DatosUsuario amigo = null;
        if(stringId!=null){
            amigo = this.datosUsuarioFacade.find(new BigDecimal(stringId));
        }

        if (amigo != null && texto != null && !texto.equals("") && usuario != null) {
            Mensaje mensajeAEnviar = this.mensajeFacade.crearMensaje(usuario.getEmail()+texto, usuario, amigo);
            mensajeAEnviar.setLeido('0');
            this.mensajeFacade.create(mensajeAEnviar);
            usuario.getMensajeCollection().add(mensajeAEnviar);
            amigo.getMensajeCollection().add(mensajeAEnviar);
            this.datosUsuarioFacade.edit(usuario);
            this.datosUsuarioFacade.edit(amigo);
        }
        
        
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/ServletListarCorreos");
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

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
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
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
 * @author adri_
 */
@WebServlet(name = "ServletListarCorreos", urlPatterns = {"/ServletListarCorreos"})
public class ServletListarCorreos extends HttpServlet {

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

        DatosUsuario usuario = (DatosUsuario) session.getAttribute("usuario");
        usuario = this.datosUsuarioFacade.find(usuario.getIdUsuario());
        String idAmigo = (String) request.getParameter("amigo");
        request.setAttribute("listaAmigos", usuario.getMisAmigos());
        List<Mensaje> lista;
        lista = (List<Mensaje>) usuario.getMensajeCollection();
        if (idAmigo == null && lista != null && !lista.isEmpty() && usuario.getMisAmigos() != null) {
            Collections.sort(lista);
            for (DatosUsuario u : lista.get(lista.size() - 1).getDatosUsuarioCollection()) {
                if (!u.equals(usuario)) {
                    idAmigo = u.getIdUsuario().toString();
                }
            }
        }
        
        if (idAmigo != null) {
            DatosUsuario amigo = this.datosUsuarioFacade.find(new BigDecimal(idAmigo));
            List<Mensaje> listaMensajesAmigo = new ArrayList<>();

            for (Mensaje mensaje : usuario.getMensajeCollection()) {
                Collection<DatosUsuario> coleccionParticipantes = mensaje.getDatosUsuarioCollection();
                if (coleccionParticipantes.contains(usuario) && coleccionParticipantes.contains(amigo)) {
                    listaMensajesAmigo.add(mensaje);
                }
                if (!mensaje.getMensaje().startsWith(usuario.getEmail())
                        && amigo!=null && mensaje.getMensaje().startsWith(amigo.getEmail())) {
                    mensaje.setLeido('1');
                    this.mensajeFacade.edit(mensaje);
                }
            }

            Collections.sort(listaMensajesAmigo);
            request.setAttribute("listaMensajesAmigo", listaMensajesAmigo);
            request.setAttribute("amigo", amigo);
        }

        for (Mensaje mensaje : usuario.getMensajeCollection()) {
            if (!mensaje.getMensaje().startsWith(usuario.getEmail()) && mensaje.getLeido() == '0') {
                request.setAttribute("mensajeDisponible", true);
            }
        }

        request.setAttribute("peticiones", usuario.getPeticionesRecibidas().size());
        session.setAttribute("usuario", usuario);
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/bandejaentrada.jsp");
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

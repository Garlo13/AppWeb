/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.ejb;

import appweb.entity.Aficion;
import java.math.BigDecimal;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author adri_
 */
@Stateless
public class AficionFacade extends AbstractFacade<Aficion> {

    @PersistenceContext(unitName = "AppWeb-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AficionFacade() {
        super(Aficion.class);
    }

    public Aficion crearAficion(String nombre) {
        Query q;
        q = this.em.createNativeQuery("select SEQ_ID_AFICION.nextval from dual");
        BigDecimal num = (BigDecimal) q.getResultList().get(0);
        Aficion aficion = new Aficion(num, nombre);
        return aficion;
    }
    
}

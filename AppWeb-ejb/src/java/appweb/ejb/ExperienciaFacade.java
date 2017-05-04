/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.ejb;

import appweb.entity.Experiencia;
import java.math.BigDecimal;
import java.util.Date;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author adri_
 */
@Stateless
public class ExperienciaFacade extends AbstractFacade<Experiencia> {

    @PersistenceContext(unitName = "AppWeb-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ExperienciaFacade() {
        super(Experiencia.class);
    }

    public Experiencia crearExperiencia(Date fechaComienzo, String empresa) {
        Query q;
        q = this.em.createNativeQuery("select SEQ_ID_EXPERIENCIA.nextval from dual");
        BigDecimal num = (BigDecimal) q.getResultList().get(0);
        Experiencia experiencia = new Experiencia(num,fechaComienzo, empresa);
        return experiencia;
    }
    
}

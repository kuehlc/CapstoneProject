package edu.ben.dao;

import java.util.ArrayList;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import edu.ben.model.Listing;
import edu.ben.model.User;

@Transactional
@Repository
public class ListingDAOImpl implements ListingDAO {
	
	@Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }
    
    public void create(Listing listing) {
        getSession().save(listing);
    }
    
    public void saveOrUpdate(Listing listing) {
        getSession().saveOrUpdate(listing);
    }
    
    public void deleteListing(int id) {
        Listing listing = (Listing) getSession().get(Listing.class, id);
        getSession().delete(listing);

    }

	@SuppressWarnings("unchecked")
	public List<Listing> getAllListingsByCategory(String category) {
    	Query q = getSession().createQuery("FROM listing WHERE category=:category");
    	q.setParameter("category", category);
    	return (List<Listing>) q.list();
    }

	@Override
	public List<Listing> getRecentListings() {
		// TODO Auto-generated method stub
		return null;
	}	

//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Listing> getRecentListings() {
//		Query q = getSession().createQuery("FROM listing ORDER BY date_created DESC");
//		System.out.println(q.getQueryString());
//		List<Listing> list = (List<Listing>) q.list();
//		Iterator<Listing> it = list.iterator();
//		List<Listing> recentListings = new ArrayList<Listing>();
//		
//		while (it.hasNext()) {
//			
//			Listing listing = it.next();
//			recentListings.add(listing);
//			
//		} 
//		
//        return recentListings;
//	}
}

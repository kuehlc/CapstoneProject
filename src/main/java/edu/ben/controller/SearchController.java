package edu.ben.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.ben.model.Listing;
import edu.ben.model.User;
import edu.ben.service.ListingService;
import edu.ben.service.UserService;

@Controller
public class SearchController {

	@Autowired
	UserService userService;
	
	@Autowired
	ListingService listingService;

	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public String searchCategory(@RequestParam("search") String search, HttpServletRequest request, Model model) {
		
		List<Listing> categoryListing = listingService.getAllListingsByCategory(search);
		System.out.println("CategoryListing Size: " + categoryListing.size());
		System.out.println(search);
		
		User user = (User) request.getSession().getAttribute("user");
		
		request.setAttribute("search", search);
		request.setAttribute("categoryListing", categoryListing);
		request.setAttribute("user", user);
		

//
//		List<Listing> categoryListing = listingService.getAllListingsByCategory(search);
//		System.out.println("CategoryListing Size: " + categoryListing.size());
//		System.out.println(search);
//
//		User user = (User) request.getSession().getAttribute("user");
//
//		request.setAttribute("category", categoryListing);
//		request.setAttribute("user", user);
//

//		System.out.println("Hit search Controller");
//		ArrayList<User> soundexResults = (ArrayList<User>) userService.soundexSearch(search);
//		System.out.println("search result size: " + soundexResults.size());
//
//		ArrayList<User> results = new ArrayList<User>();
//		ArrayList<Listing> results2 = new ArrayList<Listing>();
//
//		results.addAll(soundexResults);
//		System.out.println("results size = " + results.size());
//
//		for (int i = 0; i < results.size(); i++) {
//			results2 = results.
//		}
//		ArrayList<Listing> listings = new ArrayList<Listing>();
//
//		System.out.println("Listing size " + listings.size());
		
		

		return "searchResults";

		

	}

//	@RequestMapping(value = "/searchResults")
//	public String searchResults() {
//		return "searchResults";
//	}
}
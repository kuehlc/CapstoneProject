package edu.ben.controller;

import edu.ben.model.Dispute;
import edu.ben.model.Listing;
import edu.ben.model.Notification;
import edu.ben.model.User;
import edu.ben.service.DisputeService;
import edu.ben.service.ListingService;
import edu.ben.service.NotificationService;
import edu.ben.service.UserService;
import edu.ben.util.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class AdminController extends BaseController {

    @Autowired
    UserService userService;

    @Autowired
    ListingService listingService;

    @Autowired
    DisputeService disputeService;

    @Autowired
    NotificationService notificationService;

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    public String admin(HttpServletRequest request) {
        List<User> recentUsers = userService.getRecentUsers();
        List<Listing> recentListings = listingService.getRecentListings();
        request.getSession().setAttribute("recentUsers", recentUsers);
        request.getSession().setAttribute("recentListings", recentListings);
        return "admin/adminPage";
    }

    @RequestMapping(value = "adminUser", method = RequestMethod.GET)
    public String adminUser(HttpServletRequest request) {
        List<User> allUsers = userService.getAllUsers();
        request.getSession().setAttribute("allUsers", allUsers);
        return "admin/adminUserPage";
    }

    @RequestMapping(value = "adminUnlock", method = RequestMethod.POST)
    public String adminUnlock(HttpServletRequest request) {
        User usr = userService.findBySchoolEmail(request.getParameter("lock"));
        userService.unlockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminLock", method = RequestMethod.POST)
    public String adminLock(HttpServletRequest request) {
        User usr = userService.findBySchoolEmail(request.getParameter("unlock"));
        userService.lockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminPasswordReset", method = RequestMethod.POST)
    public String adminPasswordReset(HttpServletRequest request) {
        System.out.println(request.getParameter("email"));
        User usr = userService.findBySchoolEmail(request.getParameter("email"));
        Email.resetPassword(usr.getSchoolEmail());
        userService.lockByUsername(usr.getUsername());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminDeleteUser", method = RequestMethod.POST)
    public String adminDelete(HttpServletRequest request) {
        User usr = userService.findBySchoolEmail(request.getParameter("delete"));
        userService.deleteUser(usr.getUserID());
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminCreateUser", method = RequestMethod.POST)
    public String adminCreateUser(HttpServletRequest request) {
        User user = new User();
        user.setFirstName(request.getParameter("firstName"));
        user.setLastName(request.getParameter("lastName"));
        user.setUsername(request.getParameter("username"));
        user.setEmail(request.getParameter("personalEmail"));
        user.setSchoolEmail(request.getParameter("benedictineEmail"));
        user.setPassword(request.getParameter("password"));
        if (request.getParameter("accountType") == "Admin") {
            user.setAdmin(1);
        } else {
            user.setAdmin(0);
        }
        userService.saveOrUpdate(user);
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminEditUser", method = RequestMethod.POST)
    public String adminEditUser(HttpServletRequest request) {
        User usr = userService.findBySchoolEmail(request.getParameter("schoolEmailEdit"));
        String firstName = request.getParameter("firstNameEdit");
        String lastName = request.getParameter("lastNameEdit");
        String username = request.getParameter("usernameEdit");
        String phoneNumber = request.getParameter("phoneNumberEdit");
        String email = request.getParameter("personalEmailEdit");
        String schoolEmail = request.getParameter("schoolEmailEdit");
        String password = request.getParameter("passwordEdit");

        Pattern pattern = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$",
                Pattern.CASE_INSENSITIVE);
        if (firstName.length() < 2 || firstName.length() > 30 || firstName.matches("[A-Za-z]")) {
            addErrorMessage("Incorrect value for first name");
        } else if (lastName.length() < 2 || lastName.length() > 30 || lastName.matches("[A-Za-z]")) {
            addErrorMessage("Incorrect value for first name");
        } else if (username.length() > 8) {
            addErrorMessage("Incorrect value for username");
        } else if (phoneNumber.length() != 10) {
            addErrorMessage("Incorrect value for phone number");
        } else if ((pattern.matcher(email).matches())){
            addErrorMessage("Incorrect value for email");
        } else if ((pattern.matcher(schoolEmail).matches())) {
            addErrorMessage("Incorrect value for school email");
        } else if(password.length() > 8){
            addErrorMessage("Incorrect value for password");
        } else {
            usr.setFirstName(firstName);
            usr.setLastName(lastName);
            usr.setUsername(username);
            usr.setEmail(email);
            usr.setSchoolEmail(schoolEmail);
            usr.setPassword(password);
            userService.saveOrUpdate(usr);
        }
        return "redirect:adminUser";
    }

    @RequestMapping(value = "adminListing", method = RequestMethod.GET)
    public String adminListing(HttpServletRequest request) {
        List<Listing> allListings = listingService.getRecentListings();
        request.getSession().setAttribute("allListings", allListings);
        return "admin/adminListings";

    }

    @GetMapping("/adminDisputes")
    public String disputes(HttpServletRequest request) {

        User user = (User) request.getSession().getAttribute("user");

        if (user != null && user.getAdminLevel() < 1) {
            addErrorMessage("Access Denied");
            setRequest(request);
            return "login";
        }

        request.setAttribute("title", "Disputes");
        request.setAttribute("disputes", disputeService.getAllActive());
        return "admin/admin-disputes";
    }

    @PostMapping("/contactUser")
    public String contactUser(HttpServletRequest request, @RequestParam("receivingUser") String receivingUser, @RequestParam("disputeID") int disputeID, @RequestParam("subject") String subject, @RequestParam("message") String message) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null && user.getAdminLevel() < 1) {
            addWarningMessage("Login");
            setRequest(request);
            return "login";
        }

        Dispute dispute = disputeService.getByID(disputeID);
        if (dispute == null) {
            addErrorMessage("Invalid Dispute ID");
            setRequest(request);
            return "admin/admin-disputes";
        }

        if (receivingUser.equals("accuser")) {

            notificationService.save(new Notification(dispute.getAccuser(), dispute.getListing().getId(), "Dispute Follow Up", "A email has been sent to your school account from an administrator following up on a dispute you have filed.", 1));

            if (subject.equals("")) {
                Email.sendEmail(message, "Dispute (" + disputeID + ") Follow Up", dispute.getAccuser().getSchoolEmail());
            } else {
                Email.sendEmail(message, subject, dispute.getAccuser().getSchoolEmail());
            }

        } else {

            notificationService.save(new Notification(dispute.getDefender(), dispute.getListing().getId(), "Dispute Follow Up", "A email has been sent to your school account from an administrator following up on a dispute filed against you.", 1));

            if (subject == null) {
                Email.sendEmail(message, "Dispute (" + disputeID + ") Follow Up", dispute.getDefender().getSchoolEmail());
            } else {
                Email.sendEmail(message, subject, dispute.getDefender().getSchoolEmail());
            }

        }

        addSuccessMessage("Follow Up Email Sent");
        setRequest(request);
        return "redirect:/adminDisputes";

    }

    @PostMapping("/editDispute")
    public String editDispute(HttpServletRequest request, @RequestParam("disputeID") int disputeID, @RequestParam("newComplaint") String newComplaint, @RequestParam("newStatus") String newStatus) {

        User user = (User) request.getSession().getAttribute("user");

        if (user == null && user.getAdminLevel() < 1) {
            addWarningMessage("Login");
            setRequest(request);
            return "login";
        }

        Dispute dispute = disputeService.getByID(disputeID);
        if (dispute == null) {
            addErrorMessage("Invalid Dispute ID");
            setRequest(request);
            return "admin/admin-disputes";
        }

        dispute.setComplaint(newComplaint);
        dispute.setStatus(newStatus);

        disputeService.update(dispute);

        addSuccessMessage("Follow Up Email Sent");
        setRequest(request);
        return "redirect:/adminDisputes";
    }
}

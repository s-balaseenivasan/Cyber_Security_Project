package com.cyber.notetaking.Controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
    @RequestMapping("/")
    public String index() {
        return "index";
    }
    @RequestMapping("/login")
    public String login() {
        return "login";
    }
    @RequestMapping("register")
    public String registration() {
        return "registration";
    }
    @RequestMapping("logout")
    public String logout() {
        return "login";
    }
    @RequestMapping("addnotes")
    public String addnotes() {
        return "shownotes";
    }
}

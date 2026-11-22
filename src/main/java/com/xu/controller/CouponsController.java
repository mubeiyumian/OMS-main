package com.xu.controller;

import com.google.gson.Gson;
import com.xu.pojo.Coupons;
import com.xu.pojo.CouponsUser;
import com.xu.pojo.CouponsUserToShow;
import com.xu.pojo.User;
import com.xu.service.CouponsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CouponsController {
    private CouponsService couponsService;

    @Autowired
    public void setCouponsService(CouponsService couponsService) {
        this.couponsService = couponsService;
    }

    @RequestMapping("/addCoupons")
    public String addCoupons(Coupons coupons, Model model) {
        int res = couponsService.addCoupons(coupons);
        System.out.println(res);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        System.out.println(coupons);
        return "redirect:/allCoupons";
    }

    @RequestMapping("/allCoupons")
    public String allCoupons(Model model) {
        List<Coupons> couponsList = couponsService.getCouponsList();
        model.addAttribute("couponsList", couponsList);
        return "allCoupons";
    }

    @RequestMapping("/toAddCoupons")
    public String toAddCoupons() {
        return "addCoupons";
    }

    @RequestMapping("/toUpdateCoupons")
    public String toUpdateCoupons(int couponsId, Model model) {
        Coupons coupons = couponsService.getCouponsById(couponsId);
        System.out.println(coupons);
        model.addAttribute("coupons", coupons);
        return "updateCoupons";
    }

    @RequestMapping("/updateCoupons")
    public String updateCoupons(Coupons coupons, Model model) {
//        System.out.println(coupons);
        int res = couponsService.updateCoupons(coupons);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allCoupons";
    }

    @RequestMapping("/clientCoupons")
    public String clientCoupons() {
//        User user = (User) session.getAttribute("userLoginInfo");
//        List<CouponsUser> usrCouponsList = couponsService.getUserCoupons(user.getUserName());
//        Gson gson = new Gson();
//        System.out.println(usrCouponsList);
        return "clientCoupons";
    }

    @ResponseBody
    @RequestMapping("/clientGetCouponsInfo")
    public String clientGetCouponsInfo(HttpSession session) {
        User user = (User) session.getAttribute("userLoginInfo");
        List<CouponsUserToShow> usrCouponsList = couponsService.getUserCoupons(user.getUserName());
        Gson gson = new Gson();
        return gson.toJson(usrCouponsList);
    }

    @RequestMapping("/clientCouponsEffective")
    public String clientCouponsEffective(HttpSession session, Model model) {
        User user = (User) session.getAttribute("userLoginInfo");
        double totalPrice = (double) session.getAttribute("totalPrice");
        List<CouponsUserToShow> couponsEffective = couponsService.getEffectiveCoupons(user.getUserName(), totalPrice);
//        System.out.println(couponsEffective);
        model.addAttribute("couponsEffective", couponsEffective);
        return "clientCart";
    }

    @RequestMapping("/clientGetCouponsAll")
    public String clientgetCouponsAll(Model model, HttpSession session) {
        User user = (User) session.getAttribute("userLoginInfo");
        List<Coupons> couponsListAll = couponsService.getCouponsAll(user.getUserId());
        model.addAttribute("couponsListAll", couponsListAll);
        return "clientGetCoupons";
    }

    @RequestMapping("/clientAddUserCoupons")
    public String clientAddUserCoupons(int couponsId, HttpSession session) {
        User user = (User) session.getAttribute("userLoginInfo");
        CouponsUser couponsUser = new CouponsUser(null, couponsId, user.getUserId(), 0);
        int res = couponsService.addCouponsUser(couponsUser);
        return "clientCoupons";
    }

    @RequestMapping("/getCouponsBySuffixName")
    public String getCouponsBySuffixName(String couponsName, Model model) {
        List<Coupons> couponsList = couponsService.getCouponsBySuffixName(couponsName);
        model.addAttribute("couponsList", couponsList);
        return "allCoupons";
    }

    @RequestMapping("/clientAlertCoupons")
    public String clientGetCouponsPrice(HttpSession session) {
        int couponsType = (int) session.getAttribute("couponsType");
        CouponsUserToShow couponsUserToShow = couponsService.getUserCouponsById(couponsType);
        double totalPrice = (double) session.getAttribute("totalPrice");
        totalPrice = totalPrice - couponsUserToShow.getCouponsPrice();
        if (totalPrice < 0) totalPrice = 0.0;
        session.setAttribute("totalPrice", totalPrice);
        int res = couponsService.updateCouponsById(couponsType);
//        return "redirect:/clientBalanceModify";
        int pay = (int) session.getAttribute("pay");
        if (pay == 0) {
            return "redirect:/clientBalanceModify";
        } else {
            return "redirect:/clientAddBill";
        }
    }

    @RequestMapping("/deleteCoupons")
    public String deleteCoupons(int couponsId, Model model) {
        int res = couponsService.deleteCoupons(couponsId);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allCoupons";
    }
}

package com.xu.controller;

import com.google.gson.Gson;
import com.xu.pojo.*;
import com.xu.service.OrderingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class OrderingController {

    private OrderingService orderingService;


    @Autowired
    public void setOrderingService(OrderingService orderingService) {
        this.orderingService = orderingService;
    }


    @RequestMapping("/allOrdering")
    public String getOrderingList(Model model) {
        List<Order> orderList = orderingService.getOrderingList();
        Collections.sort(orderList);
        model.addAttribute("list", orderList);
        return "allOrdering";
    }

    @RequestMapping("/deleteOrdering")
    public String deleteOrdering(int id, Model model) {
        int res = orderingService.deleteOrdering(id);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allOrdering";
    }

    @RequestMapping("/getOrderingsByName")
    public String getOrderingsByName(String userName, Model model) {
        List<Order> orderList = orderingService.getOrderingsByName(userName);
        model.addAttribute("list", orderList);
        return "allOrdering";
    }


    @RequestMapping("/clientSubmit")
    public String clientSubmit(HttpSession session, int tableId, int pay, int couponsType, Model model) throws ParseException {
//        System.out.println(couponsType);
        session.setAttribute("couponsType", couponsType);
        session.setAttribute("tableId", tableId);
        session.setAttribute("pay", pay);
//        if (couponsType != 0){
//            System.out.println("使用优惠券");
//            CouponsUserToShow couponsUserToShow = couponsService.getUserCouponsById(couponsType);
//            double totalPrice = (Double) session.getAttribute("totalPrice");
//            totalPrice = totalPrice - couponsUserToShow.getCouponsPrice();
//            session.setAttribute("totalPrice", totalPrice);
//            int upres = couponsService.updateCouponsById(couponsType);
//        }
//        System.out.println("不使用优惠券");
        ArrayList<Order> list = (ArrayList<Order>) session.getAttribute("cartList");
        if (list.size() == 0)
            return "redirect:/clientCart";
        User user = (User) session.getAttribute("userLoginInfo");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        for (Order order : list) {
            Ordering ordering = new Ordering(null, tableId, user.getUserId(), order.getMenu().getDishesId(), order.getDishesNum(), simpleDateFormat.parse(simpleDateFormat.format(date)));
            int res = orderingService.addOrdering(ordering);
            if (res >= 1)
                model.addAttribute("state", "Success!");
            else
                model.addAttribute("state", "Fail!");
        }

        if (couponsType == 0) { //不使用优惠券，正常流程
            if (pay == 0) {
                return "redirect:/clientBalanceModify";
            } else {
                return "redirect:/clientAddBill";
            }
        } else { //使用优惠券，先判断是否需要使用余额支付
//                获取优惠券金额，转到余额进行相减，再转到账单进行添加，其中需要新增session为couponsPrice
            return "redirect:/clientAlertCoupons";
        }

//        if(pay == 0)
//            return "redirect:/clientBalanceModify";
//        else
//            return "redirect:/clientAddBill";
//        return "clientCart";
    }

    @RequestMapping("/clientCheckOrder")
    public String clientCheckOrder(Model model, HttpSession session) {
        List<Order> orderList = orderingService.getOrderingsByName(((User) session.getAttribute("userLoginInfo")).getUserName());
        System.out.println(orderList);
        model.addAttribute("list", orderList);
        return "clientCheckOrder";
    }

    @RequestMapping("/allCharts")
    public String allCharts() {
        return "allCharts";
    }

    @ResponseBody
    @RequestMapping("getChartsDish")
    public String getChartsDish() {
        List<Charts> chartsList = orderingService.getdishcnt();
        System.out.println(chartsList);
        Gson gson = new Gson();
        return gson.toJson(chartsList);
    }

    @ResponseBody
    @RequestMapping("getChartsTime")
    public String getChartsTime() {
        List<ChartsTime> chartsTimeList = orderingService.getCartsTime();
        Gson gson = new Gson();
        return gson.toJson(chartsTimeList);
    }
}

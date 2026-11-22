package com.xu.controller;

import com.xu.pojo.*;
import com.xu.service.BillService;
import com.xu.service.ConsumeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class BillController {
    private BillService billService;

    @Autowired
    public void setBillService(BillService billService) {
        this.billService = billService;
    }


    @RequestMapping("/allBill")
    public String getBillList(Model model) {
        List<BillToShow> billList = billService.getBillList();
        model.addAttribute("list", billList);
        return "allBill";
    }

    @RequestMapping("/deleteBill")
    public String deleteBill(int id, Model model) {
        int res = billService.deleteBill(id);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allBill";
    }


    @RequestMapping("/getBillsByName")
    public String getBillsByName(String userName, Model model) {
        List<BillToShow> billList = billService.getBillsByName(userName);
        model.addAttribute("list", billList);
        return "allBill";
    }

    @RequestMapping("/clientAddBill")
    public String addBill(HttpSession session, Model model) throws ParseException {
        User user = (User) session.getAttribute("userLoginInfo");
//        ArrayList<Order> list = (ArrayList<Order>) session.getAttribute("cartList");
        int couponsType = (int) session.getAttribute("couponsType");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        Bill bill = new Bill(null, user.getUserId(), (Double) session.getAttribute("totalPrice"), simpleDateFormat.parse(simpleDateFormat.format(date)), couponsType, 0);
        billService.addBill(bill);
        session.setAttribute("billId", bill.getBillId());
        session.setAttribute("date", date);
//        for(Order order:list) {
//            Consume consume = new Consume(null, bill.getBillId(), 20, user.getUserId(), order.getMenu().getDishesId(), order.getDishesNum(), simpleDateFormat.parse(simpleDateFormat.format(date)));
//            int res = consumeService.addConsume(consume);
//            if(res >= 1)
//                model.addAttribute("state", "Success!");
//            else
//                model.addAttribute("state","Fail!");
//        }
//        ((HashMap<Integer, Integer>)session.getAttribute("cart")).clear();
//        session.removeAttribute("totalPrice");
//        session.removeAttribute("couponsType");
//        session.removeAttribute("pay");
        return "redirect:/clientAddConsume";
    }

    @RequestMapping("clientConsume")
    public String clientConsume(Model model, HttpSession session) {
        User user = (User) session.getAttribute("userLoginInfo");
        List<BillToShow> billList = billService.getBillsByName(user.getUserName());
        model.addAttribute("list", billList);
        return "clientConsume";
    }
}

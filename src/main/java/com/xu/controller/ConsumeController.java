package com.xu.controller;

import com.google.gson.Gson;
import com.xu.pojo.*;
import com.xu.service.BillService;
import com.xu.service.ConsumeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Controller
public class ConsumeController {
    private BillService billService;
    private ConsumeService consumeService;

    @Autowired
    public void setBillService(BillService billService) {
        this.billService = billService;
    }

    @Autowired
    public void setConsumeService(ConsumeService consumeService) {
        this.consumeService = consumeService;
    }

//    @RequestMapping("/clientConsume")
//    public String clientConsume(HttpSession session,Model model){
//        User user = (User) session.getAttribute("userLoginInfo");
//        List<BillToShow> billList = billService.getBillsByName(user.getUserName());
//        model.addAttribute("list",billList);
//        return "clientConsume";
//    }


    @ResponseBody
    @RequestMapping("/getConsumeInfo")
    public String getConsumeInfo(int Id) {
        List<ConsumeToShow> consumeToShowList = consumeService.getConsume(Id);
        Gson gson = new Gson();
        return gson.toJson(consumeToShowList);
    }

    @RequestMapping("/clientAddConsume")
    public String clientAddConsume(Model model, HttpSession session) throws ParseException {
        int tableId = (int) session.getAttribute("tableId");
        int billId = (int) session.getAttribute("billId");
        ArrayList<Order> list = (ArrayList<Order>) session.getAttribute("cartList");
        User user = (User) session.getAttribute("userLoginInfo");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = (Date) session.getAttribute("date");
        for (Order order : list) {
            Consume consume = new Consume(null, billId, tableId, user.getUserId(), order.getMenu().getDishesId(), order.getDishesNum(), simpleDateFormat.parse(simpleDateFormat.format(date)));
            int res = consumeService.addConsume(consume);
            if (res >= 1)
                model.addAttribute("state", "Success!");
            else
                model.addAttribute("state", "Fail!");
        }
        ((HashMap<Integer, Integer>) session.getAttribute("cart")).clear();
        session.removeAttribute("totalPrice");
        session.removeAttribute("couponsType");
        session.removeAttribute("pay");
        session.removeAttribute("tableId");
        session.removeAttribute("billId");
        session.removeAttribute("date");
        return "redirect:/clientCheckOrder";
    }
}

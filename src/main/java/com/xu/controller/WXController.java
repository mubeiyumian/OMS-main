package com.xu.controller;

import com.google.gson.Gson;
import com.xu.pojo.*;
import com.xu.service.BillService;
import com.xu.service.ConsumeService;
import com.xu.service.MenuService;
import com.xu.service.OrderingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class WXController {
    private BillService billService;
    private MenuService menuService;
    private OrderingService orderingService;
    private ConsumeService consumeService;

    @Autowired
    public void setBillService(BillService billService) {
        this.billService = billService;
    }

    @Autowired
    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }

    @Autowired
    public void setOrderingService(OrderingService orderingService) {
        this.orderingService = orderingService;
    }

    @Autowired
    public void setConsumeService(ConsumeService consumeService) {
        this.consumeService = consumeService;
    }

    @ResponseBody
    @RequestMapping("wxSubmit")
    public String wxSubmit() throws ParseException {
        double totalPrice = 0;
        ArrayList<Order> list = new ArrayList<Order>();
        List<WXmap> wXmaps = menuService.selectMap();
        for (WXmap wXmap : wXmaps) {
            Order order = new Order();
            Menu menu = menuService.getDishById(wXmap.getId());
            order.setMenu(menu);
            order.setDishesNum(wXmap.getNum());
            list.add(order);
            totalPrice += menu.getUnitPrice() * order.getDishesNum();
        }
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        for (Order order : list) {
            Ordering ordering = new Ordering(null, 123, 2, order.getMenu().getDishesId(), order.getDishesNum(), simpleDateFormat.parse(simpleDateFormat.format(date)));
            int res = orderingService.addOrdering(ordering);
        }
        Bill bill = new Bill(null, 2, totalPrice, simpleDateFormat.parse(simpleDateFormat.format(date)), 0, 0);
        billService.addBill(bill);
        for (Order order : list) {
            Consume consume = new Consume(null, bill.getBillId(), 123, 2, order.getMenu().getDishesId(), order.getDishesNum(), simpleDateFormat.parse(simpleDateFormat.format(date)));
            int res = consumeService.addConsume(consume);
        }
        menuService.truncateTable();
        return "1";
    }
}

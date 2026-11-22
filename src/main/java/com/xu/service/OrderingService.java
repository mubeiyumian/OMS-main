package com.xu.service;

import com.xu.pojo.Charts;
import com.xu.pojo.ChartsTime;
import com.xu.pojo.Order;
import com.xu.pojo.Ordering;

import java.util.List;

public interface OrderingService {
    List<Order> getOrderingList();

    int deleteOrdering(int orderId);

    List<Order> getOrderingsByName(String userName);

    List<Order> getOrderingsByDishName(String dishesName);

    int addOrdering(Ordering ordering);

    List<Charts> getdishcnt();

    List<ChartsTime> getCartsTime();
}

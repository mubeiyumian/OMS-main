package com.xu.dao;

import com.xu.pojo.*;

import java.util.List;

public interface OrderingMapper {
    List<Order> getOrderingList();

    int deleteOrdering(int orderId);

    List<Order> getOrderingsByName(String userName);


    List<Order> getOrderingsByDishName(String dishesName);

    int addOrdering(Ordering ordering);

    List<Charts> getdishcnt();

    List<ChartsTime> getCartsTime();
}

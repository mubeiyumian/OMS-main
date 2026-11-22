package com.xu.service;


import com.xu.pojo.Coupons;
import com.xu.pojo.CouponsUser;
import com.xu.pojo.CouponsUserToShow;

import java.util.List;

public interface CouponsService {
    int addCoupons(Coupons coupons);

    List<Coupons> getCouponsList();

    Coupons getCouponsById(int couponsId);

    int updateCoupons(Coupons coupons);

    List<CouponsUserToShow> getUserCoupons(String userName);

    List<CouponsUserToShow> getEffectiveCoupons(String userName, double totalPrice);

    CouponsUserToShow getUserCouponsById(int couponsType);

    int updateCouponsById(int couponsType);

    List<Coupons> getCouponsAll(int userId);

    int addCouponsUser(CouponsUser couponsUser);

    List<Coupons> getCouponsBySuffixName(String couponsName);

    int deleteCoupons(int couponsId);
}

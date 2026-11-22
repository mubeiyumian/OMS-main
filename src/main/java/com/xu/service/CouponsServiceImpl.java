package com.xu.service;


import com.xu.dao.CouponsMapper;
import com.xu.pojo.Coupons;
import com.xu.pojo.CouponsUser;
import com.xu.pojo.CouponsUserToShow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CouponsServiceImpl implements CouponsService {
    private CouponsMapper couponsMapper;

    @Autowired
    public void setCouponsMapper(CouponsMapper couponsMapper) {
        this.couponsMapper = couponsMapper;
    }

    @Override
    public int addCoupons(Coupons coupons) {
        return couponsMapper.addCoupons(coupons);
    }

    @Override
    public List<Coupons> getCouponsList() {
        return couponsMapper.getCouponsList();
    }

    @Override
    public Coupons getCouponsById(int couponsId) {
        return couponsMapper.getCouponsById(couponsId);
    }

    @Override
    public int updateCoupons(Coupons coupons) {
        return couponsMapper.updateCoupons(coupons);
    }

    @Override
    public List<CouponsUserToShow> getUserCoupons(String userName) {
        return couponsMapper.getUserCoupons(userName);
    }

    @Override
    public List<CouponsUserToShow> getEffectiveCoupons(String userName, double totalPrice) {
        return couponsMapper.getEffectiveCoupons(userName, totalPrice);
    }

    @Override
    public CouponsUserToShow getUserCouponsById(int couponsType) {
        return couponsMapper.getUserCouponsById(couponsType);
    }

    @Override
    public int updateCouponsById(int couponsType) {
        return couponsMapper.updateCouponsById(couponsType);
    }

    @Override
    public List<Coupons> getCouponsAll(int userId) {
        return couponsMapper.getCouponsAll(userId);
    }

    @Override
    public int addCouponsUser(CouponsUser couponsUser) {
        return couponsMapper.addCouponsUser(couponsUser);
    }

    @Override
    public List<Coupons> getCouponsBySuffixName(String couponsName) {
        return couponsMapper.getCouponsBySuffixName(couponsName);
    }

    @Override
    public int deleteCoupons(int couponsId) {
        return couponsMapper.deleteCoupons(couponsId);
    }
}

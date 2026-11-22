package com.xu.dao;

import com.xu.pojo.Consume;
import com.xu.pojo.ConsumeToShow;

import java.util.List;

public interface ConsumeMapper {
    int addConsume(Consume consume);

    List<ConsumeToShow> getConsume(int billId);
}

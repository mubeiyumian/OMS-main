package com.xu.service;


import com.xu.pojo.Consume;
import com.xu.pojo.ConsumeToShow;

import java.util.List;

public interface ConsumeService {
    int addConsume(Consume consume);

    List<ConsumeToShow> getConsume(int billId);
}

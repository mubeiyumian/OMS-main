package com.xu.service;

import com.xu.dao.ConsumeMapper;
import com.xu.pojo.Consume;
import com.xu.pojo.ConsumeToShow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ConsumeServiceImpl implements ConsumeService {
    private ConsumeMapper consumeMapper;

    @Autowired
    public void setConsumeMapper(ConsumeMapper consumeMapper) {
        this.consumeMapper = consumeMapper;
    }

    @Override
    public int addConsume(Consume consume) {
        return consumeMapper.addConsume(consume);
    }

    @Override
    public List<ConsumeToShow> getConsume(int billId) {
        return consumeMapper.getConsume(billId);
    }

}

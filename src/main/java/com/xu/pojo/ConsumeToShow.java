package com.xu.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ConsumeToShow {
    private String dishesName;
    private double unitPrice;
    private int dishesNum;
    private double Price;
}

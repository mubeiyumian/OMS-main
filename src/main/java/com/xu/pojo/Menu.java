package com.xu.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Menu {
    private Integer dishesId;
    private String dishesName;
    private double unitPrice;
    private String cateName;
    private int categoryId;
    private int del;
    private String image;
}

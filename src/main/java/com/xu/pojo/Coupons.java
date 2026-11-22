package com.xu.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Coupons {
    private Integer couponsId;
    private String couponsName;
    private double couponsPrice;
    private double couponsThreshold;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date effectiveDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date invalidDate;
    private int state;
    private int del;
}

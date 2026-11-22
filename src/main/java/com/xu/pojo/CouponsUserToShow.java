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
public class CouponsUserToShow {
    private Integer couponsUserId;
    private String userName;
    private String couponsName;
    private double couponsPrice;
    private double couponsThreshold;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT + 8")
    private Date effectiveDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT + 8")
    private Date invalidDate;
    private int mainState; //优惠券是否过期
    private int secondState; //优惠券是否已使用
}

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
public class CouponsUser {
    private Integer couponsUserId;
    private int couponsId;
    private int userId;
    private int state; //优惠券是否过期
}

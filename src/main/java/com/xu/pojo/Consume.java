package com.xu.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Consume {
    private Integer consumeId;
    private int billId;
    private int tableId;
    private int userId;
    private int dishesId;
    private int dishesNum;
    private Date orderTime;

}

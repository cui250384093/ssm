package com.yl.pojo;

import lombok.*;

import java.util.HashMap;
import java.util.Map;

/**
 * @author candk
 * @Description
 * @date 12/14/21 - 9:09 AM
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {

    private int code;
    private String msg;

    private Map<String, Object> extend = new HashMap<>();

    public static Message success() {
        Message result = new Message();
        result.setCode(100);
        result.setMsg("Success");
        return result;
    }

    public static Message fail() {
        Message result = new Message();
        result.setCode(200);
        result.setMsg("Fail");
        return result;
    }

    public Message add(String key, Object value) {
        this.getExtend().put(key, value);
        return  this;
    }
}

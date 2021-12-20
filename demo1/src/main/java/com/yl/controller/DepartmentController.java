package com.yl.controller;

import com.yl.pojo.Department;
import com.yl.pojo.Message;
import com.yl.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author candk
 * @Description
 * @date 12/14/21 - 2:35 PM
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("depts")
    @ResponseBody
    public Message getDepts() {

        List<Department> depts = departmentService.getAllDepts();
        return Message.success().add("depts", depts);
    }
}

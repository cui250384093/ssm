package com.yl.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yl.pojo.Employee;
import com.yl.pojo.Message;
import com.yl.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.*;

/**
 * @author candk
 * @Description
 * @date 12/10/21 - 4:06 PM
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        PageHelper.startPage(pn ,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo<>(emps);
        model.addAttribute("pageInfo", page);
        return "list";
    }

    @RequestMapping("/empsJason")
    @ResponseBody
    public Message getEmpsJason(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        PageHelper.startPage(pn ,5);
        List<Employee> emps = employeeService.getAll();
        PageInfo<Employee> page = new PageInfo<>(emps);
        return Message.success().add("pageInfo", page);
    }

    @RequestMapping(value="/emp", method=RequestMethod.POST)
    @ResponseBody
    public Message saveEmp(@Valid Employee employee, BindingResult result) {

        Map<String, Object> map = new HashMap<>();
        if(result.hasErrors()) {
            for (FieldError fieldError : result.getFieldErrors()) {
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }

            return Message.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Message.success();
        }

    }

    @RequestMapping(value = "/emp/{empId}", method=RequestMethod.PUT)
    @ResponseBody
    public Message saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return null;
    }

    @RequestMapping(value = "/emp/{empId}", method=RequestMethod.DELETE)
    @ResponseBody
    public Message deleteEmpById(@PathVariable("empId")Integer empId) {
        employeeService.deleteEmpById(empId);
        return Message.success();
    }

}

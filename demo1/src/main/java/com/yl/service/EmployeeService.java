package com.yl.service;

import com.yl.dao.EmployeeMapper;
import com.yl.pojo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author candk
 * @Description
 * @date 12/13/21 - 10:44 AM
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public int deleteEmpById(Integer empId) {

        return employeeMapper.deleteByPrimaryKey(empId);
    }
}

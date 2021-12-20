package com.yl.service;

import com.yl.dao.DepartmentMapper;
import com.yl.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author candk
 * @Description
 * @date 12/14/21 - 2:36 PM
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAllDepts() {
        return departmentMapper.selectByExample(null);
    }
}

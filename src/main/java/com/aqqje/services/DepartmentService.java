package com.aqqje.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aqqje.beans.Department;
import com.aqqje.dao.DepartmentMapper;

@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	// 查询出所有的部门
	public List<Department> findAllDepts() {
		List<Department> depts = departmentMapper.selectByExample(null);
		return depts;
	}

}

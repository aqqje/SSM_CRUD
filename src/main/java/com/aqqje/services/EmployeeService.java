package com.aqqje.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aqqje.beans.Employee;
import com.aqqje.beans.EmployeeExample;
import com.aqqje.beans.EmployeeExample.Criteria;
import com.aqqje.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询出所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	// 新增一个 emp
	public void addEmp(Employee employee) {
		 employeeMapper.insertSelective(employee);
	}

	// 判断一个用户名是否可用
	public Boolean checkuser(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName)
;		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	// by Id find Emp
	public Employee findEmpById(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}

	// save Emp
	public void savaEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	// delete by Id
	public void delById(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	public void delBatch(List<Integer> list_ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		// from xxx where empId in [1,2,3,4...]
		criteria.andEmpIdIn(list_ids);
		employeeMapper.deleteByExample(example );
	}
	
//	public Employee getById() {
//		return employeeMapper.selectByPrimaryKeyWithDept(1);
//	}
//
//	public static void main(String[] args) {
//		EmployeeService employeeService = new EmployeeService();
//		List<Employee> emps = 
//		System.out.println(emp.getById().toString());
//	}
}

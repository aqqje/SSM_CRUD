package com.aqqje.controllers;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aqqje.beans.Employee;
import com.aqqje.beans.Msg;
import com.aqqje.services.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	// 判断用户是否可用
	@RequestMapping(value="/checkuser", method=RequestMethod.POST)
	@ResponseBody
	public Msg checkuser(@RequestParam("empName") String empName) {
		// ajax 用户检验
		String rex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(rex)) {
			return Msg.fail().add("message", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
		}
		Boolean flag = employeeService.checkuser(empName);
		if(flag) {
			return Msg.success();
		}else{
			return Msg.fail().add("message", "用户名不可用");
		}
	}
	
	
	/**
	 * 单个/批量删除两合一
	 * 批量删除： 1-2-3
	 * 单个： 1
	 * @param empId
	 * @return
	 */
	@RequestMapping(value="/emp/{del_idstr}", method=RequestMethod.DELETE)
	@ResponseBody
	public Msg delEmp(@PathVariable("del_idstr") String del_idstr) {
		if(del_idstr.contains("-")) {
			// 批量删除
			List<Integer> list_ids = new ArrayList<>();
			String[] empIds =  del_idstr.split("-");
			for(String empId: empIds) {
				list_ids.add(Integer.parseInt(empId));
			}
			employeeService.delBatch(list_ids);
		}else {
			// 单个删除
			Integer id = Integer.parseInt(del_idstr);
			employeeService.delById(id);
		}
		return Msg.success();
	}
	
	
//	// delete by Id
//	@RequestMapping(value="/emp/{empId}", method=RequestMethod.DELETE)
//	@ResponseBody
//	public Msg delEmp(@PathVariable("empId") Integer empId) {
//		employeeService.delById(empId);
//		return Msg.success();
//	}
	
	/**
	 * 如果直接发送ajax=PUT形式的请求
	 * 封装的数据
	 * Employee 
	 * [empId=1014, empName=null, gender=null, email=null, dId=null]
	 * 
	 * 问题：
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 * 
	 * protected String parseBodyMethods = "POST";
	 * if( !getConnector().isParseBodyMethod(getMethod()) ) {
                success = true;
                return;
            }
	 * 
	 * 
	 * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		System.out.println(employee.getEmail());
		employeeService.savaEmp(employee);
		return Msg.success();
	}

	
	
	// emp 表单回显
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee emp = employeeService.findEmpById(id);
		return Msg.success().add("emp", emp);
	}
	
	// 新增 emp
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg addEmp(@Valid Employee employee, BindingResult result ) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(result.hasErrors()) {
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError: errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		employeeService.addEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 返回 jackson 数据 
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg employeeList(@RequestParam(value="pn", defaultValue="1") Integer pn) {
		// 使用 pageHelper 设置分页
		PageHelper.startPage(pn, 5);
		// 查询出所有员工 信息
		List<Employee> employees = employeeService.getAll();
		// 使用 pageInfo 包装分页信息
		PageInfo info = new PageInfo(employees, 5);
		return Msg.success().add("info", info);
	}
	
	/**
	 * 查询所有员工信息并分页
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps_test")
	public String employeeList(
			@RequestParam(value="pn", defaultValue="1") Integer pn, 
			Model model) {
		// 使用 pageHelper 设置分页
		PageHelper.startPage(pn, 5);
		// 查询出所有员工 信息
		List<Employee> employees = employeeService.getAll();
		// 使用 pageInfo 包装分页信息
		PageInfo info = new PageInfo(employees, 5);
		// 使用 mode 将信息发送到页面
		model.addAttribute("info", info);
		return "list";
	}
}

package com.aqqje.test;

import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.CoreMatchers.nullValue;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.aqqje.beans.Department;
import com.aqqje.beans.DepartmentExample;
import com.aqqje.beans.Employee;
import com.aqqje.beans.EmployeeExample;
import com.aqqje.dao.DepartmentMapper;
import com.aqqje.dao.EmployeeMapper;

/**
 * 测试 CRUD 的 dao 层
 * @author Administrator
 * 
 * spring 项目推荐使用  spring 单元测试，可以注入我们需要的组件 
 * 1.引入 spring text jar 包
 * 2.使用  @ContextConfiguration 指定 spring 配置文件
 * 3.直接 AutoWired 使用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	/*
	 * 正常测试Department
	 * 1.创建 Spring ioc 容器
	 * 2.获取 Mapper
	 */
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		EmployeeMapper employeeMapper = ioc.getBean(EmployeeMapper.class);
//		System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1).toString());
//		System.out.println("hello");
		
		// 插入几个部门
//		departmentMapper.insertSelective(new Department(null, "生活部"));
//		departmentMapper.insertSelective(new Department(null, "开发部"));
		
		// 删除员工
//		for(int i = 1; i <= 1000; i++) {
//			departmentMapper.deleteByPrimaryKey(i);
//		}
		
		// 使用 sqlSession 执行批量插入员工
//		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
//		for(int i = 0; i <= 1000; i++) {
//			String userName = UUID.randomUUID().toString().substring(0, 5) + i;
//			employeeMapper.insertSelective(new Employee(null, userName, "M", userName + "@qq.com", 2));
//		}
		
//		System.out.println(employeeMapper.selectByPrimaryKey(1).toString());
//		Employee employee = employeeMapper.selectByPrimaryKeyWithDept(1);
		
	}
//	public static void main(String[] args) {
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		EmployeeMapper employeeMapper = ioc.getBean(EmployeeMapper.class);
//		List<Employee> emps = employeeMapper.selectByExampleWithDept(null);
//		for(Employee emp: emps) {
//			System.out.println(emp.toString());
//		}
//		System.out.println(employeeMapper.selectByPrimaryKeyWithDept(1).toString());
//		System.out.println("hello");
//	}
	
	
}

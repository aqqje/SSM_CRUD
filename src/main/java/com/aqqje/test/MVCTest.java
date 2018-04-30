package com.aqqje.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.aqqje.beans.Employee;
import com.github.pagehelper.PageInfo;

/**
 * 使用 spring-test 单元测试类：测试请求功能，测试 CRUD 的正确
 * 
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
//该注解是 spring ioc 自己装配置自己
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml", 
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MVCTest {
	// 传入 spring ioc 容器
	@Autowired
	WebApplicationContext context;
	// 一个虚拟的 mvc 请求，获取请求结果
	MockMvc mockMvc;

	// init MockMvc
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {
		// 模拟发送请求,并拿到请求值
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
		// 请求成功以后，请求域中会有pageInfo；我们可以取出pageInfo进行验证
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo info =  (PageInfo)request.getAttribute("info");
		System.out.println("当前页数：" + info.getPageNum());
		System.out.println("当前总页数：" + info.getPages());
		System.out.println("总记录数：" + info.getTotal());
		int num[] = info.getNavigatepageNums();
		for(int i = 0; i < num.length; i++) {
			System.out.println(" " + i);
		}
		
		// 获取员工列表
		List<Employee> emps = info.getList();
		for(Employee emp: emps) {
			System.out.println("empid:" + emp.getdId() + "====" + emp.getEmpName());
		}
	}

}

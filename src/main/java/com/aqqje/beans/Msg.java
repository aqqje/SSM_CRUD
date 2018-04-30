package com.aqqje.beans;

import java.util.HashMap;
import java.util.Map;

import net.sf.jsqlparser.util.AddAliasesVisitor;

public class Msg {

	// 请求状态码： 成功-100, 失败-200
	private int code;
	// 请求信息
	private String message;
	// 用户返回给浏览器的数据
	private Map<String, Object> extend = new HashMap<String, Object>();
	

	// 成为请求
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMessage("请求成功");
		return result;
	} 
	// 失败请求
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMessage("请求失败");
		return result;
	} 
	// 追加用户数据
	public  Msg add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
		
	}
	
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}

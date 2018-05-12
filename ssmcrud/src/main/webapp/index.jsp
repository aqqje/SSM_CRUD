<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	pageContext.setAttribute("APP_PATH", request.getContextPath()); 
%>
<%--  <!-- 功能跳转 -->
<jsp:forward page="/emps"/>  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<title>员工列表</title>
</head>
<body>

	<!-- emps 修改动态框 -->
	<div class="modal fade" id="emps_update_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
	      	<!-- edit emps form -->
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="emp_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
				  <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
			      <select class="form-control" name="dId"></select>
			    </div>
			  </div>
			</form>
			<!-- /edit emps form -->
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">提交</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- /emps 修改动态框 -->

	<!-- emps 新增动态框 -->
	<div class="modal fade" id="emps_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
	      	<!-- add emps form -->
	        <form class="form-horizontal">
			  <div class="form-group">
			    <label for="emp_add_input" class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="email_add_input" class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
				  <label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">部门</label>
			    <div class="col-sm-4">
			      <select class="form-control" name="dId"></select>
			    </div>
			  </div>
			</form>
			<!-- /add emps form -->
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_add_btn">提交</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- /emps 新增动态框 -->
	<!-- container -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮,新增,删除 -->
		<div class="row">
			<div class="col-md-2 col-md-offset-10">
				<button class="btn btn-primary" id="emps_add_btn">新增</button>
				<button class="btn btn-danger" id="emps_deleteAll_btn">删除</button>
			</div>
		</div>
		<!-- 表单信息 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="empstbl">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody></tbody>
					<%-- <c:forEach items="${info.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
						<td>
							<button class="btn btn-info btn-sm">
								<span class="glyphicon glyphicon-pencil" aria-hidden="true">&nbsp;编辑</span>
							</button>
							<button class="btn btn-danger btn-sm">
								<span class="glyphicon glyphicon-trash" aria-hidden="true">&nbsp;删除 </span>
							</button>
						</td>
					</tr>
					</c:forEach> --%>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<!-- 分页信息 -->
			<div class="col-md-6" id="pn_info">
			<%-- 当前 ${info.pageNum } 页,总${info.pages }页,总 ${info.total } 条记录  --%>
			</div>
			<!-- 分页条 -->
			<div class="col-md-6" id="pn_bar">
				 <%--<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				  	<c:if test="${info.hasPreviousPage }">
						<li><a href="${APP_PATH }/emps?pn=${info.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
				    <c:forEach items="${info.navigatepageNums }" var="pn_nums">
				    	<c:if test="${pn_nums == info.pageNum }">
							<li class="active"><a href="#">${pn_nums }</a></li>
						</c:if>
						<c:if test="${pn_nums != info.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${pn_nums }">${pn_nums }</a></li>
						</c:if>
				    </c:forEach>
				    <c:if test="${info.hasNextPage }">
						<li><a href="${APP_PATH }/emps?pn=${info.pageNum+1 }"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				    <li><a href="${APP_PATH }/emps?pn=${info.pages } ">尾页</a></li>
				  </ul> 
				</nav> --%>
			</div>
		</div>
	</div>
	<!-- container -->
	
	<script type="text/javascript">
	
		// 批量删除
		$("#emps_deleteAll_btn").click(function(){
		    var empNames = "";
		    var del_idstr = "";
			$.each($(".check-item:checked"), function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			empNames = empNames.substring(0, empNames.length - 1);
			del_idstr = del_idstr.substring(0, empNames.length - 1);
			if($(".check-item:checked").length >= 1){
				if(confirm("确定删除【" + empNames + "】吗？")){
					$.ajax({
						url: "${APP_PATH}/emp/" + del_idstr,
						type: "DELETE",
						success: function(result){
							alert(result.message);
							// 回到当前页
							to_pn(pageNum);
						}
					});
				}
			}else{
				alert("请选择要删除的员工！");
			}
		});
		// 全选与全不选
		$("#check_all").click(function(){
			// attr 获取自定义属性
			// dom 原生属性，使用 prop 来获取
			// $(".check-item").prop("checked", $(this).prop("checked")));
			//alert($(this).prop("checked"));
			$(".check-item").prop("checked", $(this).prop("checked"));
		});
		
		// check-item
		$(document).on("click", ".check-item", function(){
			// 判断 check-item 全选完时 返回 true
			var flag = ($(".check-item:checked").length == $(".check-item").length)
			$("#check_all").prop("checked", flag);
		});
		
		
		
		// delete-btn 绑定点击事件
		$(document).on("click", ".delete-btn", function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			if(confirm("确定删除【" + empName + "】吗？")){
				//alert($(this).attr("del-id"));
				$.ajax({
					url: "${APP_PATH}/emp/" + $(this).attr("del-id"),
					type: "DELETE",
					success: function(result){
						alert(result.message);
						// 回到当前页
						to_pn(pageNum);
					}
				});
			}
		});
		// 修改员工信息提交 btn 绑定 click 事件
		$("#emp_update_btn").click(function(){
			//1、校验邮箱信息
			//alert("${APP_PATH}/emp/"+$(this).attr("edit-id"));
			
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validata_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			}else{
				show_validata_msg("#email_update_input", "success", "");
			}
			//alert($("#emps_update_modal form").serialize()+"&_method=PUT");
			//2、发送ajax请求保存更新的员工数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type: "PUT", //"POST",
				data:$("#emps_update_modal form").serialize(), //+"&_method=PUT",
				success:function(result){	
					//alert(result.message);
					// 关闭模态框
					$("#emps_update_modal").modal('hide');
					// 回到当前页
					to_pn(pageNum);
					
				}
			});
		});
	
		// 修改员工信息绑定 click 事件
		$(document).on("click", ".update-btn", function(){
			// 1.显示员工信息
			getEmp($(this).attr("edit-id"))
			// 2.显示部门信息
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"))
			depts("#emps_update_modal select");
			// 3.显示模态框
			$('#emps_update_modal').modal({
				keyboard: "static"
			});
		});
		
		function getEmp(deitId){
			$.ajax({
				url: "${APP_PATH }/emp/" + deitId,
				type: "GET",
				success: function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#emps_update_modal input[name=gender]").val([empData.gender]);
					$("#emps_update_modal select").val([empData.dId]);
				}
			});
		}
		
		<!-- 等页面加载完后，拿到 分页 信息  -->
		// 总页数
		var pageRecrod,pageNum;
		$(function(){
			to_pn(1);
		});
		
		function to_pn(pn){
			$.ajax({
				url: "${APP_PATH }/emps",
				data: "pn=" + pn,
				type: "get",
				success: function(result){
					 //console.log(result.extend.info.list); 
					// 解析并显示员工信息
					build_emps_table(result);
					// 解析并显示分页信息 
					build_emps_nva(result);
					// 解析并显示分页条
					butil_emps_bar(result)					
				}
			});
		}
		
		 function build_emps_table(result){
			var emps = result.extend.info.list;
			$("#empstbl tbody").empty();
			$.each(emps, function(index, emps){
				//console.log(emps);
				var checkBox = $("<td><input type='checkbox' class='check-item'></td>");
				var empId = $("<td></td>").append(emps.empId);
				var empName =$("<td></td>").append(emps.empName);
				var gender =$("<td></td>").append(emps.gender=="M"?"男":"女");
				var email =$("<td></td>").append(emps.email);
				var deptName = $("<td></td>").append(emps.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-info btn-sm update-btn")
				              .append("<span></span>").addClass("glyphicon glyphicon-pencil")
				              .append("&nbsp;编辑");
				editBtn.attr("edit-id", emps.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete-btn")
	              .append("<span></span>").addClass("glyphicon glyphicon-trash")
	              .append("&nbsp;删除 ");
				delBtn.attr("del-id", emps.empId);
				var btn = $("<td></td>").append(editBtn).append("&nbsp;").append(delBtn);
				$("<tr></tr>").append(checkBox)
							  .append(empId)
						      .append(empName)
						      .append(gender)
						      .append(email)
						      .append(deptName)
						      .append(btn).appendTo("#empstbl tbody"); 
	 		});
		}  
		// 解析分页信息
		function build_emps_nva(result){
			$("#pn_info").empty();
			var info = result.extend.info;
			$("#pn_info").append("<b>当前" + info.pageNum + 
								"页,总" + info.pages + 
								"页,总 " + info.total + " 条记录</b>");
			pageRecrod = info.total;
			pageNum = info.pageNum;
		}
		
		<%-- <nav aria-label="Page navigation">
		  <ul class="pagination">
		  	<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
		  	<c:if test="${info.hasPreviousPage }">
				<li><a href="${APP_PATH }/emps?pn=${info.pageNum-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:if>
		    <c:if test="${info.hasNextPage }">
				<li><a href="${APP_PATH }/emps?pn=${info.pageNum+1 }"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:if>
		    <li><a href="${APP_PATH }/emps?pn=${info.pages } ">尾页</a></li>
		  </ul>
		</nav> --%>
		// 解析分页条
		function butil_emps_bar(result){
			// 数据清空
			$("#pn_bar").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("首页"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			// 不可点
			if(result.extend.info.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			// 绑定点击事件
			}else{
				firstPageLi.click(function(){
					to_pn(1);
				});
				prePageLi.click(function(){
					to_pn(result.extend.info.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").attr("href", "#").append("尾页"));
			if(result.extend.info.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				lastPageLi.click(function(){
					to_pn(result.extend.info.pages);
				});
				nextPageLi.click(function(){
					to_pn(result.extend.info.pageNum + 1);
				});
			}
			// 添加 首页 和 前页
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.info.navigatepageNums, function(index, pages){
				var pageLi = $("<li></li>").append($("<a></a>").append(pages));
				if(result.extend.info.pageNum == pages){
					pageLi.addClass("active");
				}
				pageLi.click(function(){
					to_pn(pages);
				});
				ul.append(pageLi);
			});
			// 添加 尾页  和 后页
			ul.append(nextPageLi).append(lastPageLi);
			ul.appendTo($("#pn_bar"));
		}
		// // 表单完整重置
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		$("#emps_add_btn").click(function(){
			// 表单重置
			reset_form("#emps_add_modal form")
			//$("#emps_add_modal form")[0].reset();
			// 查出所有部门信息到下拉列表中
			depts("#emps_add_modal select");
			// 显示增加模态框
			$('#emps_add_modal').modal({
				keyboard: "static"
			});
		});
		
		// 查出所有部门信息到下拉列表中
		function depts(ele){
			// 清空信息
			$(ele).empty();
			$.ajax({
				url: "${APP_PATH }/depts",
				type: "get",
				success: function(result){
					//console.log(result);
					//extend{depts: [{deptId: 1, deptName: "学习部"}, 
				    //{deptId: 2, deptName: "生活部"}, {deptId: 3, deptName: "开发部"}]}
					$.each(result.extend.depts, function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		// 表单检验
		function validata_add_input(){
			// 用户名检验
			var empName = $("#empName_add_input").val();
			var empNameReg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!empNameReg.test(empName)){
				//alert("用户名可以是2-5位中文");
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名可以是2-5位中文");
				show_validata_msg($("#empName_add_input"), "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				//$("#empName_add_input").parent().addClass("has-success");
				//$("#empName_add_input").next("span").text("");
				show_validata_msg($("#empName_add_input"),"success", "");
				return true;
			}
			
			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空这个元素之前的样式
				show_validata_msg("#email_add_input", "error", "邮箱格式不正确");
				/* $("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("邮箱格式不正确"); */
				return false;
			}else{
				show_validata_msg("#email_add_input", "success", "");
				return true;
			}
		}
		
		// 检验
		function show_validata_msg(ele, status, msg){
			// 清除元素
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		// 保存提交的新增 emp 表单
		$("#emp_add_btn").click(function(){
			
			// 1.模态框填写信息提交给服务器进行保存
			// 前端 JQuery 表单进行检验
			if(!validata_add_input()){
				return false;
			};
			// 判断之前 ajax 请求是成功
			if($(this).attr("ajax-va") == "error"){
				return false;
			}
			// 2.发送 Ajax 请求进行保存
			$.ajax({
				url: "${APP_PATH }/emp",
				type: "POST",
				data: $("#emps_add_modal form").serialize(),
				success: function(result){
					if(result.code == 100){
					//alert(result.message);
					// 3.关闭模态框
					$("#emps_add_modal").modal('hide');
					// 4.更新到最后一页
					to_pn(pageRecrod);
					// jsr303 后台校验
					}else{
						// 显示失败信息
						//console.log(result);
						// 什么字段不正确就显示那个字段
						if(("undefined" != result.extend.errorFields.email)){
							//alert(result.extend.errorFields.email);
							show_validata_msg("#email_add_input", "error", result.extend.errorFields.email);
						}else if(("undefined" != result.extend.errorFields.empName)){
							//alert(result.extend.errorFields.empName);
							show_validata_msg($("#empName_add_input"), "error", result.extend.errorFields.empName);
						}
					}
				}
			});
		});
		
		// 检验用户名是否已存在
		$("#empName_add_input").change(function(){
			// 发送 ajax 请求判断用户名是否可以用
			var empName = this.value;
			$.ajax({
				url: "${APP_PATH }/checkuser",
				data: "empName=" + empName,
				type: "POST",
				success: function(result){
					// 100 用户可用
					if(result.code == 100 ){
						show_validata_msg("#empName_add_input", "success", "用户名可用");
						$("#emp_add_btn").attr("ajax-va", "success");
					// 200 用户不可用
					}else{
						show_validata_msg("#empName_add_input", "error", result.extend.message);
						$("#emp_add_btn").attr("ajax-va", "error");
					}
				}
			});
		});
	</script>
</body>
</html>
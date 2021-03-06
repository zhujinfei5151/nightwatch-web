<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>自定义函数配置</title>
	<!-- 装饰:默认 -->
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content">
<div class="ibox">
<div class="ibox-title">
		<h5>自定义函数配置</h5>
		<div class="ibox-tools">
			<a class="collapse-link">
				<i class="fa fa-chevron-up"></i>
			</a>
			<a class="close-link">
				<i class="fa fa-times"></i>
			</a>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
	<!-- 查询条件 -->
	<div class="row">
	<div class="col-sm-12">
	<form:form id="searchForm" action="${ctx}/rtc/udf/list" modelAttribute="udf" method="post"  class="form-inline">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<div class="form-group">
			<span>关键词：&nbsp;</span>
			<form:input path="keyword" htmlEscape="false" maxlength="20" class="form-control input-sm"/>
		 </div>
	</form:form>
	<br/>
	</div>
	</div>
	
	<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12">
		<div class="pull-left">
			<shiro:hasPermission name="rtc:udf:add">
				<table:addRow url="${ctx}/rtc/udf/form" title="自定义函数"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
	       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		</div>
		<div class="pull-right">
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
			<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="reset()" ><i class="fa fa-refresh"></i> 重置</button>
		</div>
	</div>
	</div>
	
	<table id="contentTable" class="table table-striped table-bordered table-hover table-condensed dataTables-example dataTable">
		<thead>
			<tr>
				<th hidden="true"><div style="width:auto;text-align:center;" >ID</div></th>
				<th><div style="width:auto;text-align:center;">方法全类名</div></th>
				<th><div style="width:auto;text-align:center;">方法描述</div></th>
				<th><div style="width:auto;text-align:center;">缓存清除策略</div></th>
				<th><div style="width:auto;text-align:center;">缓存生命周期</div></th>
				<th><div style="width:auto;text-align:center;">缓存清理间隔</div></th>
				<th><div style="width:auto;text-align:center;">操作</div></th>
			</tr>
		</thead>
		<tbody><%request.setAttribute("strEnter", "\n");request.setAttribute("strTab", "\t");%>
		<c:choose>
			<c:when test="${not empty page.list}">
				<c:forEach items="${page.list}" var="udf">
					<tr>
						<td hidden="true">${udf.id}</td>
						<td>${udf.methodName}</td>
						<td>${udf.methodDescribe}</td>
						<td>${fns:getDictLabel(udf.cacheReferenceType, 'cache_reference_type', '')}</td>
						<td>${udf.maxAgeSeconds}</td>
						<td>${udf.purgeIntervalSeconds}</td>
						<td>
								<shiro:hasPermission name="rtc:udf:view">
									<a href="#" onclick="openDialogView('详情', '${ctx}/rtc/udf/form?id=${udf.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>详情</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="rtc:udf:edit">
									<a href="#" onclick="openDialog('编辑', '${ctx}/rtc/udf/form?id=${udf.id}','800px', '500px')" class="btn btn-info btn-xs" ><i class="fa fa-search-plus"></i>编辑</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="rtc:udf:del">
									<a href="${ctx}/rtc/udf/delete?id=${udf.id}" onclick="return confirmx('确定要删除该函数吗？', this.href)" class="btn btn-danger btn-xs" ><i class="fa fa-trash"></i>删除</a>
								</shiro:hasPermission>
						</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr class="main_info">
					<td colspan="100" class="center" align="center">没有相关数据</td>
				</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>
	
	<!-- 分页代码 -->
	<table:page page="${page}"></table:page>
	<br/>
	<br/>
	</div>
	</div>
</div>
</body>
</html>
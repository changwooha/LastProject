<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<div class="form-group form-group-sm">
	<div class="col-sm-10">
		<form:textarea path="boardContent" style="height:7em;resize:none"
			class="form-control" rows="50" cols="50" />
	</div>
</div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglib.jsp" %>
<div class="card shadow-sm border-0 mb-4">
    <div class="card-header bg-primary text-white fw-bold py-3">
        <i class="fa fa-list me-2"></i> Danh mục sản phẩm
    </div>
    <div class="list-group list-group-flush">
        <a href="${ctx}/home" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span><i class="fa fa-th-large me-2 text-primary"></i> Tất cả danh mục</span>
        </a>
        <a href="${ctx}/video" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
            <span><i class="fa fa-video me-2 text-danger"></i> Kênh Video</span>
        </a>
    </div>
</div>

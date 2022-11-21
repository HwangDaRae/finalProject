
<form id="feedInfo">

	<!-- 피드 내용 -->
	<div class="post-area clear-after">
	
		<article role="main">
			<img src="/resources/image/uploadFiles/${feed.user.profileImage}" style="vertical-align: sub; display: inline-block; width:50px; height:50px;" />
			<h4>${feed.user.nickName}</h4>

			<input class="plain button purple btn_update" value="submit">
			
			<h5 class="meta-post">
				<c:if test="${!empty feed.updateDate}">${feed.updateDate}</c:if>
				<c:if test="${empty feed.updateDate}">${feed.regDate}</c:if>
			</h5>
			
			<textarea id="summernote" name="fullContent">${feed.fullContent}</textarea>
			
		</article>

	</div>

	<!-- 댓글 관련 hidden -->
	<input type="hidden" name="source" value="0">
	<input type="hidden" name="openCondition" value="3">
	<input type="hidden" name="userId" value="${sessionScope.user.userId}">
	<input type="hidden" name="feedNo" value="${feed.feedNo}">
	
	<!-- 댓글 관련 hidden -->
</form>
					
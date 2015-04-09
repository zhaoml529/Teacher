$(function(){
	var ctx = $("#ctx").val();
	KindEditor.ready(function(K) {
		var editor = K.create('textarea[name="content",name="remark",name="beizhu"]', {
			uploadJson : ctx+"/uploadJson/file_upload",
			fileManagerJson : ctx+"/uploadJson/file_manager",
			minWidth : '500px',
			langType:"zh_CN",
			allowFileManager : true,
			items : [
					'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
					'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
					'insertunorderedlist', '|', 'emoticons', 'image', 'link'],
			afterCreate : function() {
				var self = this;
				K.ctrl(document, 13, function() {
					self.sync();
				});
				K.ctrl(self.edit.doc, 13, function() {
					self.sync();
				});
			}
		});
	})
})
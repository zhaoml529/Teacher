KindEditor.ready(function(K) {
	var editor1 = K.create('textarea[name="content"]', {
		uploadJson : 'uploadJson/file_upload',
		fileManagerJson : 'uploadJson/file_manager',
		minWidth : '500px',
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
	prettyPrint();
});
function doSearch(currentPage)
{
	var pageNum = document.getElementById("pageNum").value;
	if(isNaN(pageNum))
	{
		alert("请输入正确的行数!");
	}
	else
	{
		document.getElementById('currentPage').value = currentPage;
		alert("pageNum: "+pageNum+"   currentPage: "+currentPage);
		document.forms[0].submit();
	}
}

/**
 * 隐藏文字过长，加省略号。。。
 * body onload 调用displayPart
 * div id = displayPart  加入...
 * 默认长度 displayLength= 100
 * div 自定义长度 <div id="displayPart" displayLength="40">
 */
$.fn.extend({
    displayPart:function () {
        var displayLength = 100;
        displayLength = this.attr("displayLength") || displayLength;
        var text = this.text();
        if (!text) return "";

        var result = "";
        var count = 0;
        for (var i = 0; i < displayLength; i++) {
            var _char = text.charAt(i);
            if (count >= displayLength)  break;
            if (/[^x00-xff]/.test(_char))  count++;  //双字节字符，//[u4e00-u9fa5]中文

            result += _char;
            count++;
        }
        if (result.length < text.length) {
            result += "...";
        }
        this.text(result);
    }
});

function displayPart ( totalSum ) {
	for(var i=0; i<totalSum;i++){
        $("#displayPart"+i).displayPart();
	}
}

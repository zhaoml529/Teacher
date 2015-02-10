

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

//end 省略字符

/**
 * 站内信 全选 全不选 已读 未读 选中变色
 * addDate: 2014-12-31 02:31:12
 * author: ZML
 */
  function selectAll( flag ) { 
	//flag = true 选取checkAll 否则不选
    var obj = document.getElementsByName("checkAll");
    var checkAll = document.getElementById("checkAll");
    var parent = obj[0].parentNode;
    if(parent.tagName == 'TD'){
    	//普通checkbox全选功能
        for(var i=0; i<obj.length; i++) { 
          obj[i].checked=true; 
          changeTRColor(obj[i], true);
        }
        if(flag){
			checkAll.checked=true;
		}
    }
    if(parent.tagName == 'DIV'){
    	//针对icheck插件的全选功能
        for(var i=0; i<obj.length; i++) { 
        	$(obj[i].parentNode).addClass('checked');
        	obj[i].checked=true;	//普通的也要选上
        	changeTRColor(obj[i], true);
        }
        if(flag){
			$(checkAll.parentNode).addClass('checked');
			checkAll.checked=true;
		}
    }
  } 
  
  function unSelect( flag ) {
	var obj = document.getElementsByName("checkAll"); 
	var checkAll = document.getElementById("checkAll");
    var parent = obj[0].parentNode;
    if(parent.tagName == 'TD'){ 
    	//普通checkbox全选功能
        for(var i=0; i<obj.length; i++) { 
          obj[i].checked=false; 
          changeTRColor(obj[i], false);
        }
        if(!flag){
			checkAll.checked=false;
		}
    }
    if(parent.tagName == 'DIV'){
    	//针对icheck插件的全选功能
        for(var i=0; i<obj.length; i++) { 
        	$(obj[i].parentNode).removeClass('checked');
        	obj[i].checked=false;	//普通的要不选
        	changeTRColor(obj[i], false);
        }
        if(!flag){
        	$(checkAll.parentNode).removeClass('checked');
			checkAll.checked=false;
		}
    }
  }

  function viewSelect( flag ){
	  var parent = null;
	  var view1 = $("input[id='view1']");	//已读
	  var view0 = $("input[id='view0']");   //未读
	  if(view1.length == 0 && view0.length == 0){
		  return;
	  }
	  if(flag && view1.length != 0){		//已读
		  unSelect(false);
		  parent = view1[0].parentNode;
		  
		  if(parent.tagName == 'TD'){
			  //普通的已读的checkbox全选
		      for(var i=0; i<view1.length; i++) { 
		    	  view1[i].checked=true;
		    	  changeTRColor(view1[i], true);
		      }
			  //并且取消未读
			  if(view0.length != 0){
				  for(var i=0; i<view0.length; i++) { 
			    	  view0[i].checked=false; 
			    	  changeTRColor(view0[i], false);
			      }
			  }
		  }
		  
		  if(parent.tagName == 'DIV'){
		      //针对icheck插件的已读全选功能
		      for(var i=0; i<view1.length; i++) { 
		    	  $(view1[i].parentNode).addClass('checked');
		    	  view1[i].checked=true;	//普通的也要选上
		    	  changeTRColor(view1[i], true);
		      }
		      //并且取消未读
			  if(view0.length != 0){
				  for(var i=0; i<view0.length; i++) { 
					  $(view0[i].parentNode).removeClass('checked');
					  view0[i].checked=false;	//普通的要不选
					  changeTRColor(view0[i], false);
			      } 
			  }
		  }
	  }
	  
	  if(!flag && view0.length != 0){		//未读
		  unSelect(false);
		  parent = view0[0].parentNode;
		  if(parent.tagName == 'TD'){
			  //普通的未读的checkbox全选
		      for(var i=0; i<view0.length; i++) { 
		    	  view0[i].checked=true; 
		    	  changeTRColor(view0[i], true);
		      }
			  //并且取消已读的
			  if(view1.length != 0){
				  for(var i=0; i<view1.length; i++) { 
			    	  view1[i].checked=false; 
			    	  changeTRColor(view1[i], false);
			      } 
			  }
		  }
		  
		  if(parent.tagName == 'DIV'){
		      //针对icheck插件的未读全选功能
		      for(var i=0; i<view0.length; i++) { 
		    	  $(view0[i].parentNode).addClass('checked');
		    	  view0[i].checked=true;	//普通的也要选上
		    	  changeTRColor(view0[i], true);
		      }
		      //并且取消已读的
			  if(view1.length != 0){
				  for(var i=0; i<view1.length; i++) { 
					  $(view1[i].parentNode).removeClass('checked');
					  view1[i].checked=false;	//普通的要不选
					  changeTRColor(view1[i], false);
			      } 
			  }
		  }
		  
	  }
  }
  
  function changeTRColor( obj, flag ){
	  //obj <==> view1[i]。  flag:true添加颜色  false删除颜色
	  var row = obj.parentNode.parentNode;
      while (row.tagName != "TR") row = row.parentNode;
      var r = row.rowIndex;
      //checked_行
      var id = "checked_"+r;
      if(flag){
    	  //添加颜色
	      $("#"+id).attr("class", "danger");	//可选颜色class=active、success、warning、danger、info 
      }else{
    	  //取消颜色
    	  $("#"+id).removeAttr("class");
      }
  }
  
  //------------------------------------------------------------
  //end 站内信

MyIOSPlugin.nativeFunction("alert",['这是HTML5的温馨提示，您知道了吗？亲！','温馨提示','OK']);
(function(){
 $("#newsDetailView").live("pagebeforeshow",function(){
//                           $("#praiseBtn").off().on("click", praiseBtnClick);
                           });
 
 function praiseBtnClick(){
        // console.log("你点赞了");
        MyIOSPlugin.nativeFunction("alert",['这是HTML5的温馨提示，您知道了吗？亲！','温馨提示','OK']);
 }
 }
 })();
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs

$(document).ready(function(){
	// If a framed finding aid from OASIS
	if(parent.FindingAid!=undefined){
		var x=window.frames[0].document.getElementsByTagName("a");
		for(var i=0;i<x.length;i++){
			if(x.item(i).getAttribute("target")=="urnPage"){
				var link=x.item(i).getAttribute("href")
			}
		}
		f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent(link)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
		a=function(){
			if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
		};
		if(/Firefox/.test(navigator.userAgent)){
			setTimeout(a,0);
			history.forward()
		}
		else{
			a()
		}
	}
	else{
		// If an unframed finding aid from OASIS
		var y=window.document.getElementById("permurn");
		if(y!=undefined){
			f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent(y.innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
			a=function(){
				if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
			};
			if(/Firefox/.test(navigator.userAgent)){
				setTimeout(a,0);
				history.forward()
			}
			else{
				a()
			}
		}
		else{
			// If from PDS
			if(document.domain=="pds.lib.harvard.edu"){
				myWin=window.open(window.location.href.replace("view","fullcitation"),"");
				// If IE
				if(/MSIE (\d+\.\d+);/.test(navigator.userAgent)){
					function ieLoaded(){
	    				var wBody=myWin.document.getElementsByTagName("body");
	    				if(wBody[0]==null){
	        				setTimeout(ieLoaded, 10);
	    				}
	    				else{
	        				f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent(myWin.document.getElementsByTagName("dd")[5].innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
							a=function(){
								if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
							};
							if(/Firefox/.test(navigator.userAgent)){
								setTimeout(a,0);
								history.back()
							}
							else{
								a();
							}
							myWin.close()
	    				}
	    			}	
					ieLoaded();
				}
				else{
					function wload(){
						f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent(myWin.document.getElementsByClassName("resUrn")[1].innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
						a=function(){
							if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
						};
						if(/Firefox/.test(navigator.userAgent)){
							setTimeout(a,0);
						}
						else{
							a();
						}
						myWin.close()
					}
					myWin.onload=wload
				}	
			}
			else{
				// If from VIA
				if(document.domain=="via.lib.harvard.edu"){
					var o=window.document.getElementsByTagName("option");
					if(o.length!=0){
						for(var i=0;i<o.length;i++){
							if(o.item(i).innerHTML=="... Bookmark this record"){
								link=o.item(i).getAttribute("value");
								strInd=link.search("bookmarkTitle");
								str=link.slice(strInd);
								titleInd=str.search("=");
								title=str.slice(titleInd+1);
								f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent(link)+"&tagged_item%5btitle%5d="+encodeURIComponent(title)+"&";
								a=function(){
									if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
								};
								if(/Firefox/.test(navigator.userAgent)){
									setTimeout(a,0);
									history.forward()
								}
								else{
									a()
								}	
							}	
						}
					}
					else{
						var alink=window.document.getElementsByTagName("a");
						for(var i=0;i<alink.length;i++){
							if(alink.item(i).innerHTML.indexOf("Bookmark this item") != -1){
								f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burn%5d="+encodeURIComponent($("table").find("a[onclick]").attr("onclick").split("','")[1])+"&tagged_item%5btitle%5d="+encodeURIComponent(alink.item(i).getAttribute("title"))+"&";
								a=function(){
									if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700,resizable=yes,scrollbars=yes"))location.href=f+"jump=yes"
								};
								if(/Firefox/.test(navigator.userAgent)){
									setTimeout(a,0);
									history.forward()
								}
								else{
									a()
								}
							}	
						}
					}	
				}
				else{
					// If not a Finding Aid, PDS or VIA
					alert("Use in OASIS, PDS or VIA.")
				}
			}
		}
	}

})();

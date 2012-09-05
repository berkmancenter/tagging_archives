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

(function(){

	if(parent.FindingAid!=undefined){
		var x=window.frames[0].document.getElementsByTagName("a");
		for(var i=0;i<x.length;i++){
			if(x.item(i).getAttribute("target")=="urnPage"){
				var link=x.item(i).getAttribute("href")
			}
		}
		f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burl%5d="+encodeURIComponent(link)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
		a=function(){
			if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700"))location.href=f+"jump=yes"
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
		var y=window.document.getElementById("permurn");
		if(y!=undefined){
			f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burl%5d="+encodeURIComponent(y.innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
			a=function(){
				if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700"))location.href=f+"jump=yes"
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
			if(document.domain=="pds.lib.harvard.edu"){
				myWin=window.open(window.location.href.replace("view","fullcitation"),"");
				if(/MSIE (\d+\.\d+);/.test(navigator.userAgent)){
					function ieLoaded(){
	    				var wBody=myWin.document.getElementsByTagName("body");
	    				if(wBody[0]==null){
	        				setTimeout(ieLoaded, 10);
	    				}
	    				else{
	        				f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burl%5d="+encodeURIComponent(myWin.document.getElementsByTagName("dd")[5].innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
							a=function(){
								if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700"))location.href=f+"jump=yes"
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
						f="http://0.0.0.0:3000/bookmarklets/add?tagged_item%5burl%5d="+encodeURIComponent(myWin.document.getElementsByClassName("resUrn")[1].innerHTML)+"&tagged_item%5btitle%5d="+encodeURIComponent(document.title)+"&";
						a=function(){
							if(!window.open(f+"noui=1&jump=doclose","tagging_archives","width=560,height=700"))location.href=f+"jump=yes"
						};
						if(/Firefox/.test(navigator.userAgent)){
							setTimeout(a,0);
							history.back()
						}
						else{
							a();
							history.back()
						}
						myWin.close()
					}
					myWin.onload=wload
				}	
			}
			else{
				alert("Use on a finding aid.")
			}
		}
	}

})();

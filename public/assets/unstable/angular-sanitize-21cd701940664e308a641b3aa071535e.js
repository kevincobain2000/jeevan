!function(t,e){"use strict";function n(t){var e,n={},r=t.split(",");for(e=0;e<r.length;e++)n[r[e]]=!0;return n}function r(t,n){function r(t,r,i,l){if(r=e.lowercase(r),y[r])for(;m.last()&&k[m.last()];)s("",m.last());x[r]&&m.last()==r&&s("",r),l=b[r]||!!l,l||m.push(r);var c={};i.replace(u,function(t,e,n,r,s){var i=n||r||s||"";c[e]=a(i)}),n.start&&n.start(r,c,l)}function s(t,r){var a,s=0;if(r=e.lowercase(r))for(s=m.length-1;s>=0&&m[s]!=r;s--);if(s>=0){for(a=m.length-1;a>=s;a--)n.end&&n.end(m[a]);m.length=s}}var i,l,p,m=[],v=t;for(m.last=function(){return m[m.length-1]};t;){if(l=!0,m.last()&&z[m.last()])t=t.replace(new RegExp("(.*)<\\s*\\/\\s*"+m.last()+"[^>]*>","i"),function(t,e){return e=e.replace(f,"$1").replace(h,"$1"),n.chars&&n.chars(a(e)),""}),s("",m.last());else if(0===t.indexOf("<!--")?(i=t.indexOf("-->"),i>=0&&(n.comment&&n.comment(t.substring(4,i)),t=t.substring(i+3),l=!1)):g.test(t)?(p=t.match(o),p&&(t=t.substring(p[0].length),p[0].replace(o,s),l=!1)):d.test(t)&&(p=t.match(c),p&&(t=t.substring(p[0].length),p[0].replace(c,r),l=!1)),l){i=t.indexOf("<");var w=0>i?t:t.substring(0,i);t=0>i?"":t.substring(i),n.chars&&n.chars(a(w))}if(t==v)throw"Parse Error: "+t;v=t}s()}function a(t){return E.innerHTML=t.replace(/</g,"&lt;"),E.innerText||E.textContent||""}function s(t){return t.replace(/&/g,"&amp;").replace(m,function(t){return"&#"+t.charCodeAt(0)+";"}).replace(/</g,"&lt;").replace(/>/g,"&gt;")}function i(t){var n=!1,r=e.bind(t,t.push);return{start:function(t,a,i){t=e.lowercase(t),!n&&z[t]&&(n=t),n||1!=$[t]||(r("<"),r(t),e.forEach(a,function(t,n){var a=e.lowercase(n);1!=C[a]||A[a]===!0&&!t.match(p)||(r(" "),r(n),r('="'),r(s(t)),r('"'))}),r(i?"/>":">"))},end:function(t){t=e.lowercase(t),n||1!=$[t]||(r("</"),r(t),r(">")),t==n&&(n=!1)},chars:function(t){n||r(s(t))}}}var l=function(t){var e=[];return r(t,i(e)),e.join("")},c=/^<\s*([\w:-]+)((?:\s+[\w:-]+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)\s*>/,o=/^<\s*\/\s*([\w:-]+)[^>]*>/,u=/([\w:-]+)(?:\s*=\s*(?:(?:"((?:[^"])*)")|(?:'((?:[^'])*)')|([^>\s]+)))?/g,d=/^</,g=/^<\s*\//,f=/<!--(.*?)-->/g,h=/<!\[CDATA\[(.*?)]]>/g,p=/^((ftp|https?):\/\/|mailto:|tel:|#)/,m=/([^\#-~| |!])/g,b=n("area,br,col,hr,img,wbr"),v=n("colgroup,dd,dt,li,p,tbody,td,tfoot,th,thead,tr"),w=n("rp,rt"),x=e.extend({},w,v),y=e.extend({},v,n("address,article,aside,blockquote,caption,center,del,dir,div,dl,figure,figcaption,footer,h1,h2,h3,h4,h5,h6,header,hgroup,hr,ins,map,menu,nav,ol,pre,script,section,table,ul")),k=e.extend({},w,n("a,abbr,acronym,b,bdi,bdo,big,br,cite,code,del,dfn,em,font,i,img,ins,kbd,label,map,mark,q,ruby,rp,rt,s,samp,small,span,strike,strong,sub,sup,time,tt,u,var")),z=n("script,style"),$=e.extend({},b,y,k,x),A=n("background,cite,href,longdesc,src,usemap"),C=e.extend({},A,n("abbr,align,alt,axis,bgcolor,border,cellpadding,cellspacing,class,clear,color,cols,colspan,compact,coords,dir,face,headers,height,hreflang,hspace,ismap,lang,language,nohref,nowrap,rel,rev,rows,rowspan,rules,scope,scrolling,shape,span,start,summary,target,title,type,valign,value,vspace,width")),E=document.createElement("pre");e.module("ngSanitize",[]).value("$sanitize",l),e.module("ngSanitize").directive("ngBindHtml",["$sanitize",function(t){return function(e,n,r){n.addClass("ng-binding").data("$binding",r.ngBindHtml),e.$watch(r.ngBindHtml,function(e){e=t(e),n.html(e||"")})}}]),e.module("ngSanitize").filter("linky",function(){var t=/((ftp|https?):\/\/|(mailto:)?[A-Za-z0-9._%+-]+@)\S*[^\s\.\;\,\(\)\{\}\<\>]/,n=/^mailto:/;return function(r,a){if(!r)return r;var s,l,c,o=r,u=[],d=i(u),g={};for(e.isDefined(a)&&(g.target=a);s=o.match(t);)l=s[0],s[2]==s[3]&&(l="mailto:"+l),c=s.index,d.chars(o.substr(0,c)),g.href=l,d.start("a",g),d.chars(s[0].replace(n,"")),d.end("a"),o=o.substring(c+s[0].length);return d.chars(o),u.join("")}})}(window,window.angular);
!function(a){a.extend(a.inputmask.defaults.definitions,{h:{validator:"[01][0-9]|2[0-3]",cardinality:2,prevalidator:[{validator:"[0-2]",cardinality:1}]},s:{validator:"[0-5][0-9]",cardinality:2,prevalidator:[{validator:"[0-5]",cardinality:1}]},d:{validator:"0[1-9]|[12][0-9]|3[01]",cardinality:2,prevalidator:[{validator:"[0-3]",cardinality:1}]},m:{validator:"0[1-9]|1[012]",cardinality:2,prevalidator:[{validator:"[01]",cardinality:1}]},y:{validator:"(19|20)\\d{2}",cardinality:4,prevalidator:[{validator:"[12]",cardinality:1},{validator:"(19|20)",cardinality:2},{validator:"(19|20)\\d",cardinality:3}]}}),a.extend(a.inputmask.defaults.aliases,{"dd/mm/yyyy":{mask:"1/2/y",placeholder:"dd/mm/yyyy",regex:{val1pre:new RegExp("[0-3]"),val1:new RegExp("0[1-9]|[12][0-9]|3[01]"),val2pre:function(e){var r=a.inputmask.escapeRegex.call(this,e);return new RegExp("((0[1-9]|[12][0-9]|3[01])"+r+"[01])")},val2:function(e){var r=a.inputmask.escapeRegex.call(this,e);return new RegExp("((0[1-9]|[12][0-9])"+r+"(0[1-9]|1[012]))|(30"+r+"(0[13-9]|1[012]))|(31"+r+"(0[13578]|1[02]))")}},leapday:"29/02/",separator:"/",yearrange:{minyear:1900,maxyear:2099},isInYearRange:function(a,e,r){var t=parseInt(a.concat(e.toString().slice(a.length))),n=parseInt(a.concat(r.toString().slice(a.length)));return(0/0!=t?t>=e&&r>=t:!1)||(0/0!=n?n>=e&&r>=n:!1)},determinebaseyear:function(a,e){var r=(new Date).getFullYear();return a>r?a:r>e?e:r},onKeyUp:function(e,r){var t=a(this);if(e.ctrlKey&&e.keyCode==r.keyCode.RIGHT){var n=new Date;t.val(n.getDate().toString()+(n.getMonth()+1).toString()+n.getFullYear().toString())}},definitions:{1:{validator:function(a,e,r,t,n){var i=n.regex.val1.test(a);return t||i||a.charAt(1)!=n.separator&&-1=="-./".indexOf(a.charAt(1))||!(i=n.regex.val1.test("0"+a.charAt(0)))?i:(e[r-1]="0",{pos:r,c:a.charAt(0)})},cardinality:2,prevalidator:[{validator:function(a,e,r,t,n){var i=n.regex.val1pre.test(a);return t||i||!(i=n.regex.val1.test("0"+a))?i:(e[r]="0",r++,{pos:r})},cardinality:1}]},2:{validator:function(a,e,r,t,n){var i=e.join("").substr(0,3),y=n.regex.val2(n.separator).test(i+a);return t||y||a.charAt(1)!=n.separator&&-1=="-./".indexOf(a.charAt(1))||!(y=n.regex.val2(n.separator).test(i+"0"+a.charAt(0)))?y:(e[r-1]="0",{pos:r,c:a.charAt(0)})},cardinality:2,prevalidator:[{validator:function(a,e,r,t,n){var i=e.join("").substr(0,3),y=n.regex.val2pre(n.separator).test(i+a);return t||y||!(y=n.regex.val2(n.separator).test(i+"0"+a))?y:(e[r]="0",r++,{pos:r})},cardinality:1}]},y:{validator:function(a,e,r,t,n){if(n.isInYearRange(a,n.yearrange.minyear,n.yearrange.maxyear)){var i=e.join("").substr(0,6);if(i!=n.leapday)return!0;var y=parseInt(a,10);return y%4===0?y%100===0?y%400===0?!0:!1:!0:!1}return!1},cardinality:4,prevalidator:[{validator:function(a,e,r,t,n){var i=n.isInYearRange(a,n.yearrange.minyear,n.yearrange.maxyear);if(!t&&!i){var y=n.determinebaseyear(n.yearrange.minyear,n.yearrange.maxyear).toString().slice(0,1);if(i=n.isInYearRange(y+a,n.yearrange.minyear,n.yearrange.maxyear))return e[r++]=y[0],{pos:r};if(y=n.determinebaseyear(n.yearrange.minyear,n.yearrange.maxyear).toString().slice(0,2),i=n.isInYearRange(y+a,n.yearrange.minyear,n.yearrange.maxyear))return e[r++]=y[0],e[r++]=y[1],{pos:r}}return i},cardinality:1},{validator:function(a,e,r,t,n){var i=n.isInYearRange(a,n.yearrange.minyear,n.yearrange.maxyear);if(!t&&!i){var y=n.determinebaseyear(n.yearrange.minyear,n.yearrange.maxyear).toString().slice(0,2);if(i=n.isInYearRange(y+a[1],n.yearrange.minyear,n.yearrange.maxyear))return e[r++]=y[1],{pos:r};if(y=n.determinebaseyear(n.yearrange.minyear,n.yearrange.maxyear).toString().slice(0,2),n.isInYearRange(y+a,n.yearrange.minyear,n.yearrange.maxyear)){var d=e.join("").substr(0,6);if(d!=n.leapday)i=!0;else{var s=parseInt(a,10);i=s%4===0?s%100===0?s%400===0?!0:!1:!0:!1}}else i=!1;if(i)return e[r-1]=y[0],e[r++]=y[1],e[r++]=a[0],{pos:r}}return i},cardinality:2},{validator:function(a,e,r,t,n){return n.isInYearRange(a,n.yearrange.minyear,n.yearrange.maxyear)},cardinality:3}]}},insertMode:!1,autoUnmask:!1},"mm/dd/yyyy":{placeholder:"mm/dd/yyyy",alias:"dd/mm/yyyy",regex:{val2pre:function(e){var r=a.inputmask.escapeRegex.call(this,e);return new RegExp("((0[13-9]|1[012])"+r+"[0-3])|(02"+r+"[0-2])")},val2:function(e){var r=a.inputmask.escapeRegex.call(this,e);return new RegExp("((0[1-9]|1[012])"+r+"(0[1-9]|[12][0-9]))|((0[13-9]|1[012])"+r+"30)|((0[13578]|1[02])"+r+"31)")},val1pre:new RegExp("[01]"),val1:new RegExp("0[1-9]|1[012]")},leapday:"02/29/",onKeyUp:function(e,r){var t=a(this);if(e.ctrlKey&&e.keyCode==r.keyCode.RIGHT){var n=new Date;t.val((n.getMonth()+1).toString()+n.getDate().toString()+n.getFullYear().toString())}}},"yyyy/mm/dd":{mask:"y/1/2",placeholder:"yyyy/mm/dd",alias:"mm/dd/yyyy",leapday:"/02/29",onKeyUp:function(e,r){var t=a(this);if(e.ctrlKey&&e.keyCode==r.keyCode.RIGHT){var n=new Date;t.val(n.getFullYear().toString()+(n.getMonth()+1).toString()+n.getDate().toString())}},definitions:{2:{validator:function(a,e,r,t,n){var i=e.join("").substr(5,3),y=n.regex.val2(n.separator).test(i+a);if(!t&&!y&&(a.charAt(1)==n.separator||-1!="-./".indexOf(a.charAt(1)))&&(y=n.regex.val2(n.separator).test(i+"0"+a.charAt(0))))return e[r-1]="0",{pos:r,c:a.charAt(0)};if(y){var d=e.join("").substr(4,4)+a;if(d!=n.leapday)return!0;var s=parseInt(e.join("").substr(0,4),10);return s%4===0?s%100===0?s%400===0?!0:!1:!0:!1}return y},cardinality:2,prevalidator:[{validator:function(a,e,r,t,n){var i=e.join("").substr(5,3),y=n.regex.val2pre(n.separator).test(i+a);return t||y||!(y=n.regex.val2(n.separator).test(i+"0"+a))?y:(e[r]="0",r++,{pos:r})},cardinality:1}]}}},"dd.mm.yyyy":{mask:"1.2.y",placeholder:"dd.mm.yyyy",leapday:"29.02.",separator:".",alias:"dd/mm/yyyy"},"dd-mm-yyyy":{mask:"1-2-y",placeholder:"dd-mm-yyyy",leapday:"29-02-",separator:"-",alias:"dd/mm/yyyy"},"mm.dd.yyyy":{mask:"1.2.y",placeholder:"mm.dd.yyyy",leapday:"02.29.",separator:".",alias:"mm/dd/yyyy"},"mm-dd-yyyy":{mask:"1-2-y",placeholder:"mm-dd-yyyy",leapday:"02-29-",separator:"-",alias:"mm/dd/yyyy"},"yyyy.mm.dd":{mask:"y.1.2",placeholder:"yyyy.mm.dd",leapday:".02.29",separator:".",alias:"yyyy/mm/dd"},"yyyy-mm-dd":{mask:"y-1-2",placeholder:"yyyy-mm-dd",leapday:"-02-29",separator:"-",alias:"yyyy/mm/dd"},datetime:{mask:"1/2/y h:s",placeholder:"dd/mm/yyyy hh:mm",alias:"dd/mm/yyyy",regex:{hrspre:new RegExp("[012]"),hrs24:new RegExp("2[0-9]|1[3-9]"),hrs:new RegExp("[01][0-9]|2[0-3]"),ampmpre:new RegExp("[apAP]"),ampm:new RegExp("^[a|p|A|P][m|M]")},timeseparator:":",hourFormat:"24",definitions:{h:{validator:function(a,e,r,t,n){var i=n.regex.hrs.test(a);if(!t&&!i&&(a.charAt(1)==n.timeseparator||-1!="-.:".indexOf(a.charAt(1)))&&(i=n.regex.hrs.test("0"+a.charAt(0))))return e[r-1]="0",e[r]=a.charAt(0),r++,{pos:r};if(i&&"24"!==n.hourFormat&&n.regex.hrs24.test(a)){var y=parseInt(a,10);return 24==y?(e[r+5]="a",e[r+6]="m"):(e[r+5]="p",e[r+6]="m"),y-=12,10>y?(e[r]=y.toString(),e[r-1]="0"):(e[r]=y.toString().charAt(1),e[r-1]=y.toString().charAt(0)),{pos:r,c:e[r]}}return i},cardinality:2,prevalidator:[{validator:function(a,e,r,t,n){var i=n.regex.hrspre.test(a);return t||i||!(i=n.regex.hrs.test("0"+a))?i:(e[r]="0",r++,{pos:r})},cardinality:1}]},t:{validator:function(a,e,r,t,n){var i=n.regex.ampm.test(a);return t||i||!(i=n.regex.ampm.test(a+"m"))?i:(e[r-1]=a.charAt(0),e[r]="m",r++,r)},casing:"lower",cardinality:2,prevalidator:[{validator:function(a,e,r,t,n){var i=n.regex.ampmpre.test(a);return i&&(i=n.regex.ampm.test(a+"m"))?(e[r]=a,e[r+1]="m",r):i},cardinality:1}]}},insertMode:!1,autoUnmask:!1},datetime12:{mask:"1/2/y h:s t",placeholder:"dd/mm/yyyy hh:mm xm",alias:"datetime",hourFormat:"12"},"hh:mm t":{mask:"h:s t",placeholder:"hh:mm xm",alias:"datetime",hourFormat:"12"},"h:s t":{mask:"h:s t",placeholder:"hh:mm xm",alias:"datetime",hourFormat:"12"},"hh:mm:ss":{mask:"h:s:s",autoUnmask:!1},"hh:mm":{mask:"h:s",autoUnmask:!1},date:{alias:"dd/mm/yyyy"}})}(jQuery);
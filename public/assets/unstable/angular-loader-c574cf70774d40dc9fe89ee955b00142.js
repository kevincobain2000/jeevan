!function(r){function e(r,e,n){return r[e]||(r[e]=n())}return e(e(r,"angular",Object),"module",function(){var r={};return function(n,i,o){return i&&r.hasOwnProperty(n)&&(r[n]=null),e(r,n,function(){function r(r,n,i){return function(){return e[i||"push"]([r,n,arguments]),c}}if(!i)throw Error("No module: "+n);var e=[],t=[],u=r("$injector","invoke"),c={_invokeQueue:e,_runBlocks:t,requires:i,name:n,provider:r("$provide","provider"),factory:r("$provide","factory"),service:r("$provide","service"),value:r("$provide","value"),constant:r("$provide","constant","unshift"),animation:r("$animationProvider","register"),filter:r("$filterProvider","register"),controller:r("$controllerProvider","register"),directive:r("$compileProvider","directive"),config:u,run:function(r){return t.push(r),this}};return o&&u(o),c})}})}(window),angular.Module;
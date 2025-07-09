module.exports = function() { return `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"><script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(e,n,t){function r(t){if(!n[t]){var o=n[t]={exports:{}};e[t][0].call(o.exports,function(n){var o=e[t][1][n];return r(o||n)},o,o.exports)}return n[t].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<t.length;o++)r(t[o]);return r}({1:[function(e,n,t){function r(){}function o(e,n,t){return function(){return i(e,[c.now()].concat(u(arguments)),n?null:this,t),n?void 0:this}}var i=e("handle"),a=e(3),u=e(4),f=e("ee").get("tracer"),c=e("loader"),s=NREUM;"undefined"==typeof window.newrelic&&(newrelic=s);var p=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],d="api-",l=d+"ixn-";a(p,function(e,n){s[n]=o(d+n,!0,"api")}),s.addPageAction=o(d+"addPageAction",!0),s.setCurrentRouteName=o(d+"routeName",!0),n.exports=newrelic,s.interaction=function(){return(new r).get()};var m=r.prototype={createTracer:function(e,n){var t={},r=this,o="function"==typeof n;return i(l+"tracer",[c.now(),e,t],r),function(){if(f.emit((o?"":"no-")+"fn-start",[c.now(),r,o],t),o)try{return n.apply(this,arguments)}catch(e){throw f.emit("fn-err",[arguments,this,e],t),e}finally{f.emit("fn-end",[c.now()],t)}}}};a("actionText,setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(e,n){m[n]=o(l+n)}),newrelic.noticeError=function(e,n){"string"==typeof e&&(e=new Error(e)),i("err",[e,c.now(),!1,n])}},{}],2:[function(e,n,t){function r(e,n){if(!o)return!1;if(e!==o)return!1;if(!n)return!0;if(!i)return!1;for(var t=i.split("."),r=n.split("."),a=0;a<r.length;a++)if(r[a]!==t[a])return!1;return!0}var o=null,i=null,a=/Version\/(\S+)\s+Safari/;if(navigator.userAgent){var u=navigator.userAgent,f=u.match(a);f&&u.indexOf("Chrome")===-1&&u.indexOf("Chromium")===-1&&(o="Safari",i=f[1])}n.exports={agent:o,version:i,match:r}},{}],3:[function(e,n,t){function r(e,n){var t=[],r="",i=0;for(r in e)o.call(e,r)&&(t[i]=n(r,e[r]),i+=1);return t}var o=Object.prototype.hasOwnProperty;n.exports=r},{}],4:[function(e,n,t){function r(e,n,t){n||(n=0),"undefined"==typeof t&&(t=e?e.length:0);for(var r=-1,o=t-n||0,i=Array(o<0?0:o);++r<o;)i[r]=e[n+r];return i}n.exports=r},{}],5:[function(e,n,t){n.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],ee:[function(e,n,t){function r(){}function o(e){function n(e){return e&&e instanceof r?e:e?f(e,u,i):i()}function t(t,r,o,i){if(!d.aborted||i){e&&e(t,r,o);for(var a=n(o),u=v(t),f=u.length,c=0;c<f;c++)u[c].apply(a,r);var p=s[y[t]];return p&&p.push([b,t,r,a]),a}}function l(e,n){h[e]=v(e).concat(n)}function m(e,n){var t=h[e];if(t)for(var r=0;r<t.length;r++)t[r]===n&&t.splice(r,1)}function v(e){return h[e]||[]}function g(e){return p[e]=p[e]||o(t)}function w(e,n){c(e,function(e,t){n=n||"feature",y[t]=n,n in s||(s[n]=[])})}var h={},y={},b={on:l,addEventListener:l,removeEventListener:m,emit:t,get:g,listeners:v,context:n,buffer:w,abort:a,aborted:!1};return b}function i(){return new r}function a(){(s.api||s.feature)&&(d.aborted=!0,s=d.backlog={})}var u="nr@context",f=e("gos"),c=e(3),s={},p={},d=n.exports=o();d.backlog=s},{}],gos:[function(e,n,t){function r(e,n,t){if(o.call(e,n))return e[n];var r=t();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(e,n,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return e[n]=r,r}var o=Object.prototype.hasOwnProperty;n.exports=r},{}],handle:[function(e,n,t){function r(e,n,t,r){o.buffer([e],r),o.emit(e,n,t)}var o=e("ee").get("handle");n.exports=r,r.ee=o},{}],id:[function(e,n,t){function r(e){var n=typeof e;return!e||"object"!==n&&"function"!==n?-1:e===window?0:a(e,i,function(){return o++})}var o=1,i="nr@id",a=e("gos");n.exports=r},{}],loader:[function(e,n,t){function r(){if(!E++){var e=x.info=NREUM.info,n=l.getElementsByTagName("script")[0];if(setTimeout(s.abort,3e4),!(e&&e.licenseKey&&e.applicationID&&n))return s.abort();c(y,function(n,t){e[n]||(e[n]=t)}),f("mark",["onload",a()+x.offset],null,"api");var t=l.createElement("script");t.src="https://"+e.agent,n.parentNode.insertBefore(t,n)}}function o(){"complete"===l.readyState&&i()}function i(){f("mark",["domContent",a()+x.offset],null,"api")}function a(){return O.exists&&performance.now?Math.round(performance.now()):(u=Math.max((new Date).getTime(),u))-x.offset}var u=(new Date).getTime(),f=e("handle"),c=e(3),s=e("ee"),p=e(2),d=window,l=d.document,m="addEventListener",v="attachEvent",g=d.XMLHttpRequest,w=g&&g.prototype;NREUM.o={ST:setTimeout,SI:d.setImmediate,CT:clearTimeout,XHR:g,REQ:d.Request,EV:d.Event,PR:d.Promise,MO:d.MutationObserver};var h=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-1118.min.js"},b=g&&w&&w[m]&&!/CriOS/.test(navigator.userAgent),x=n.exports={offset:u,now:a,origin:h,features:{},xhrWrappable:b,userAgent:p};e(1),l[m]?(l[m]("DOMContentLoaded",i,!1),d[m]("load",r,!1)):(l[v]("onreadystatechange",o),d[v]("onload",r)),f("mark",["firstbyte",u],null,"api");var E=0,O=e(5)},{}]},{},["loader"]);</script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Privacy Policy | Nithra</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet"> 
    <link href="css/lightbox.css" rel="stylesheet"> 
	<link href="css/main.css" rel="stylesheet">
	<link href="css/responsive.css" rel="stylesheet"> 
	<link href="additional/add.css" rel="stylesheet"> 

    <!--[if lt IE 9]>
	    <script src="js/html5shiv.js"></script>
	    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="images/ico/32.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/144.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/114.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/72.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/57.png">
    <style>
        @media only screen and (max-width: 768px){
            .border{
                border-bottom: 1px solid #ccc;
            }
            .border1{
                padding-bottom: 20px;
                border-bottom: 1px solid #ccc;
            }
            .single-features * {
                display: inline-block;
                text-align: justify; 
            }
        }
        h2,h3,h4{
            line-height: 30px;
        }
        .nav-up {
            top: -40px;
        }
    </style>
    <script>
        
    </script>
</head><!--/head-->

<body class="while-bg" style="font-family:'Lucida Sans Unicode', 'Lucida Grande', sans-serif;">
    <header id="header" class="navbar-fixed-top">      
        <div class="navbar navbar-inverse" role="banner">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" >
                    	<h1>Nithra Edu Solutions India Pvt. Ltd.</h1>
                    </a>
                    
                </div>
            </div>
        </div>
    </header>
    <!--/#header-->

    <section id="features" >
        <div class="container">
            <div class="row">
                <div class="single-features border1">
                    <div class="col-sm-2 wow fadeInRight" data-wow-duration="500ms" data-wow-delay="300ms">
                        <img src="mobile.png" class="img-responsive" alt="">
                    </div>
                    <div class="col-sm-9 wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                        <h2><span>Privacy Policy</span></h2>
                        <h4>(For All apps and websites of Nithra)</h4>
                        <h4>Please read this Privacy Policy very carefully. This contains important information about Your rights and obligations. This Privacy Policy sets out the manner in which Nithra Edu Solutions India Pvt. Ltd. (hereinafter referred to as "Nithra", “We”, “Us”) collects, uses, maintains and discloses information collected from the users of our mobile or desktop application and websites (hereinafter referred to as 'You', 'Your', 'User'). This Privacy Policy applies to the Nithra mobile or desktop application software/ technology and websites (hereinafter referred as "App", “Websites”) which is owned by Nithra. By downloading, installing or using or by registering Your profile with the App or website, You are consenting to the use, collection, transfer, storage, disclosure and other uses of Your information in the manner set out in this Privacy policy.</h4>
                        <h4>This Privacy Policy does not apply to the practises of third parties that Nithra does not own, control, or manage including but not limited to any third party websites, services, applications, or businesses ("Third Party Services"). Nithra does not take responsibility for the content or privacy policies of those Third Party Services. Nithra encourages You to carefully review the privacy policies of all Third Party Services You access.</h4>
                        <h4>If You do not agree to any of the provisions of this Privacy Policy, You should not download, install and use the App or website. Nithra may revise, alter, add, amend or modify this Privacy Policy at any time by updating this page. By downloading, installing and/or using this App, You agree to be bound by any such alteration, amendment, addition or modification.</h4>
                    </div>
                    <div class="col-sm-10 col-sm-offset-1 wow fadeInLeft" data-wow-duration="500ms" data-wow-delay="300ms">
                        <h2><span>1. INFORMATION WE MAY COLLECT THROUGH OUR APP:</span></h2>
                        <h3><span>•	1.1. Personally Identifiable Information</span></h3>
                        <h4>Nithra may collect personal information that identifies you in a variety of ways, including, but not limited to the information submitted during download and installation of the App or in connection with registration for other activities or features offered through the App or website. Personally identifiable Information collected may include name, mailing address, email address, phone number and demographic information such as gender, nationality, postcode and other personal information.
Nithra collect Personally Identifiable Information only if you voluntarily submit such information to us or provide access to such information by connecting to social networking sites through the App or website for example when you use the facilities available on the App or engage in certain App related activities including but not limited to becoming a member or signing up for an account or linking an account through a social network including, but not limited to Facebook, Twitter, Google Plus, and LinkedIn or when corresponding with us by e-mail or phone to use any other interactive features of the App or website.
You can always refuse to supply personally identifiable information, except that it may prevent You from using the App or website, or certain features of the App or website.
</h4>
                        <h2><span>•	1.2. Non-personally Identifiable Information</span></h2>
                        <h4>Nithra may collect non-personal information about you whenever you access or interact with our App or any of the related services. This includes but not limited to browser name, version, server location, device specific information such as the type of device used, users’ operating system and version, your mobile devices unique device ID, third party apps or websites or App or website service that referred users to our App or website, language preference, means of connection to our App and services location information, internet service providers, IP address, technical information and other similar information about you.</h4>
                        <h2><span>2. HOW NITHRA USES THE COLLECTED INFORMATION?</span></h2>
                        <h3><span>•	2.1. Nithra may collect and use Your personal information for the following purposes:</span></h3>
                        <h4>Nithra may use this information to control your access to the App or website as well as use of the App or website, to communicate with the you, customize your experience of using the App or website and and/or the content of any email newsletter or other material that Nithra may send from time to time and provide information that may be useful or interesting based on the content and personally identifiable information relating to you.</h4>
                        <h4>Your email address will be used to send user information, administrative information, changes in account settings and any changes to the App or website or updating User on new policies of Nithra. Apart from this if you choose to opt-in to our mailing list, you will receive periodic emails that may relate to company news, related product or service information, etc. Email address may also be used for responding to any of the inquiries, questions, and/or any other requests made by You. If at any time You want to unsubscribe from receiving future emails, Nithra has included detailed unsubscribe instructions at the bottom of each email or you may contact Nithra via the App or website.</h4>
                        <h4>Nithra may further use the collected information to analyse the use of the App or website, and the people visiting and using the App or website, for the purpose of improving the features of the App or website.
Information provided by you help Nithra in responding to Your customer service requests and support needs more efficiently. Nithra may use information in the aggregate to understand how users, as a group are using the App or website.</h4>
                        <h4>Nithra may use the personal information provided by the User to prevent or take action against activities that are, or may be, in breach of the "Nithra User Agreement", "Terms and Conditions" and any applicable laws.</h4>
                        <h2><span>3. HOW NITHRA PROTECTS USER'S INFORMATION</span></h2>
                        <h4>•	3.1. Nithra adopts appropriate data collection, storage and processing practices and security measures to protect against unauthorized access, alteration, disclosure or destruction of Your personal information, username, password, and data stored on the App. Sensitive and private data exchange between the Application and its users happens over a SSL (Secure Socket Layer) secured communication channel. However, Nithra cannot guarantee the security of any information obtained through unauthorized entry or use, hardware or software failure, and other factors that may compromise the security of user information at any time. It is important for the User to prevent unauthorized access to his/her account and personal information by limiting access to his/her device.</h4>
                        <h2><span>4. SHARING USER'S PERSONAL INFORMATION</span></h2>
                        <h4>•	4.1. Nithra does not sell, trade, or rent Your personally identifiable information collected by Nithra.</h4>
                        <h4>•	4.2. At times Nithra may be required by law or litigation to disclose personal information about the users. Nithra may also disclose information about the user if Nithra determines that for national security, law enforcement, or other issues of public importance that disclosure of information is necessary.</h4>
                       
                        <h2><span>5. COOKIES</span></h2>
                        <h4>•	5.1. Whenever you access the App or website we may place "cookies" on your hard drive for record-keeping purposes to enhance your experience or sometimes to personalize your experience. Cookies are small text files that are placed on your computer’s or mobile’s hard drive by the App you visit. Cookies help us to identify information relating your activities and to retain information relating to your preferences and history on the App.</h4>
                        <h4>•	5.2. Ad targeting cookies: Nithra and/or our service providers may use advertising cookies to deliver ads that are more relevant to you and your interests.</h4>
                        <h4>•	5.3. You may choose to disable cookies by turning off cookie feature on the web browser. However, by disabling this feature, some parts of the App may not function properly. This may prevent You from taking full advantage of the App.</h4>
                        <h2><span>6. WHAT CHOICES USER HAS REGARDING THE USE OF HIS/HER INFORMATION</span></h2>
                        <h4>•	6.1. In case, if the user is receiving marketing or promotional emails from Nithra, You have the option to "opt out" of such marketing emails by following the instructions in those mails or by emailing Nithra at feedback@nithra.mobi. If the user opts out, he/she may still receive non-promotional emails from Nithra, such as emails about his/her account or any ongoing business relations entered into by Nithra.</h4>
                        <h2><span>7. CHANGES TO THIS PRIVACY POLICY</span></h2>
                        <h4>•	7.1. Nithra may update and revise this Privacy Policy from time to time. The revised Privacy Policy will be posted as notification here on this link www.nithra.mobi/privacy.php. You are encouraged to periodically check this page to stay informed about changes to this Privacy Policy. You hereby acknowledge and agree that it is your responsibility to review this Privacy Policy periodically and become aware of the modifications. If you disagree to any of the changes to the Privacy Policy, you shall refrain from using or accessing the App or website. Your continued use of the App following the posting of the revised Policy shall indicate your acceptance and acknowledgement of the changes and you will be bound by it.</h4>
                        <h2><span>8. YOUR ACCEPTANCE OF THESE TERMS OF PRIVACY POLICY</span></h2>
                        <h4>•	8.1. By using our App or website, you are signifying your acceptance of this Privacy Policy. If you do not agree to this Privacy Policy, You shall not access or use our App or website. Your continued Access or Use of our Apps or websites following the posting of changes to this Privacy Policy will be deemed to be the acceptance of these changes by the User.</h4>
                        <h2><span>9. CONTACTING US</span></h2>
                        <h4>•	9.1. If You have any questions about this Privacy Policy, practices of our Apps and websites or Your dealings with the Apps or websites or any of the features or any Legal Queries about the Apps and websites , please contact Nithra at: feedback@nithra.mobi</h4><hr>
                        <h6>This Document was last updated on 8th November 2018.</h6>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/lightbox.min.js"></script>
    <script type="text/javascript" src="js/wow.min.js"></script>
    <script type="text/javascript" src="js/main.js"></script>   
    <script type="text/javascript" src="js/jquery.bootstrap-autohidingnavbar.min.js"></script>   
    
    <script>
        
        $(".navbar-fixed-top").autoHidingNavbar(
            // see next for specifications
        );
    $( document ).ready(function() {
        $('#features1').click(function(){
            $("#home").removeClass("active");
            $("#footer1").removeClass("active");
            $("#features1").addClass("active");
        });
        $('#footer1').click(function(){
            $("#home").removeClass("active");
            $("#features1").removeClass("active");
            $("#footer1").addClass("active");
        });
        if(window.location.hash) {
            $("#home").removeClass("active");
            $("#features1").addClass("active");
        }
    });    
    </script>
<script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","licenseKey":"4c184d965d","applicationID":"52193243","transactionName":"NABUMUJUVkdVW0VaCQ1KYxdZGkhGXU5QUB9NFV4V","queueTime":0,"applicationTime":0,"atts":"GEdXRwpORUk=","errorBeacon":"bam.nr-data.net","agent":""}</script></body>
</html>`};

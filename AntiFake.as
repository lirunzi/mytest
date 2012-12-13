package {
	import flash.display.*;
	import flash.errors.*;
	import flash.events.*;
	import flash.external.*;
	import flash.net.*;
	import flash.utils.*;
	
	import flash.system.*;
	import flash.ui.*;
	
	
	public class AntiFake extends Sprite{
		
		private static var FlashCookie : SharedObject;
		public static var API_HOST : String;
		public static var API_COOKIENAME : String;
		private static var DOMAIN_WHITE_LIST:Array = [
			".163.com",
			".126.com",
			".188.com",			
		];
		
		public function AntiFake(){
			var oParam:Object;
			oParam = LoaderInfo(this.root.loaderInfo).parameters;
			API_HOST = "apiHost" in oParam ? (String(oParam.apiHost).toLowerCase()) : ("");
			API_COOKIENAME = "apiName" in oParam ? (String(oParam.apiName).toLowerCase()) : ("vipmail_flashcookie");
			FlashCookie = SharedObject.getLocal(API_COOKIENAME,"/");
			registerAllowedDomains();
			//registerCallbacks();
			registerJsFun();			
			return;
		}
		
		private function registerJsFun():void{        	
			if(ExternalInterface.available){
				try{
					var readyTimer:Timer=new Timer(100);
					readyTimer.addEventListener(TimerEvent.TIMER,timeHandler);
					readyTimer.start();				
				}catch(error:Error){
					//trace(error)
				}
			}else{
				//trace("External interface is not available for this container.");
			}
		}
			
		private function timeHandler(event:TimerEvent):void{			
			var isReady:Boolean=isContainerReady();
			if(isReady){
				Timer(event.target).stop();
				registerCallbacks();				
			}
		}
			
		private function isContainerReady():Boolean{
			var result:Boolean=Boolean(ExternalInterface.call("isPageReady"));
			return result;
		}
		
		//域名检查
		private static function registerAllowedDomains() : void{
			if(API_HOST){
            	var i:int,l:int,s:String,n:int;
				for(i=0,l=DOMAIN_WHITE_LIST.length;i<l;i++){
					s = DOMAIN_WHITE_LIST[i];
					n = API_HOST.indexOf(s);
					if(n != -1 && n+s.length == API_HOST.length){
						Security.allowDomain(API_HOST);
						break;
					}
				}
			}
            return;
         }
         
         //获取cookie
         public function getFlashCookie(name : String) : String{         	       	
         	return FlashCookie.data[name];
         }
         
         //设置cookie
         public function setFlashCookie(name : String, value:String) : Boolean{
         	FlashCookie.data[name] = value;
         	try{
         		var flushResult : String = FlashCookie.flush();
         		if(flushResult == SharedObjectFlushStatus.FLUSHED){ 
         			return true;
         		}
         		else if(flushResult == SharedObjectFlushStatus.PENDING){
         			FlashCookie.addEventListener(NetStatusEvent.NET_STATUS,onStatus);
         		}
         	}catch(e:Error){
         		//用户禁止保存数据，打开settions对话框
         		Security.showSettings(SecurityPanel.LOCAL_STORAGE);
         	}
         		function onStatus(evt:NetStatusEvent):Boolean{
				FlashCookie.removeEventListener(NetStatusEvent.NET_STATUS,onStatus);
				//用户同意允许请求更多的空间
				if(evt.info.code == 'SharedObject.Flush.Success') {
					return setFlashCookie(name,value);
				}	
				return false;
			 }			 
         	return false;	 
         }
         
         //删除cookie
         public function deleFlashCookie(name : String) : Boolean{
         	if(FlashCookie){
         		if(name && name != null){
         			delete FlashCookie.data[name];
         			FlashCookie.flush();
         		}else{
         			FlashCookie.clear();         		
         		}
         		return true;
         	}
         	return false;
         } 
         
         private function registerCallbacks() : void{
            if(ExternalInterface.available){				
    	        ExternalInterface.addCallback("setFlashCookie", setFlashCookie);
				ExternalInterface.addCallback("getFlashCookie", getFlashCookie);
				ExternalInterface.addCallback("deleFlashCookie", deleFlashCookie);
                ExternalInterface.call("sCookieSwfIsReady"); 				
            }
            return;
        }
	}	
}

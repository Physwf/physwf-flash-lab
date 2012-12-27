package com.physwf.application.login.msg
{
	import flash.utils.Dictionary;

	public class MessageManager
	{
		private var mMsgDic:Dictionary;
		
		public static var instance:MessageManager = new MessageManager();
		
		public function MessageManager()
		{
		}
		
		public function registerMessage():void
		{
			regMsg(103,MSG_RES_LOGIN_103);
		}
		
		private function regMsg(mid:uint,MSG:Class):void
		{
			mMsgDic[mid] = MSG;
		}
		
		public function getMSG(mid:uint):Class
		{
			return mMsgDic[mid] as Class;
		}
	}
}
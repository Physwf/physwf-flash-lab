package com.physwf.application.login.msg
{
	import com.physwf.shell.interfaces.IDestroyable;
	
	import flash.utils.Dictionary;

	public class MessageManager implements IDestroyable
	{
		private var mMsgDic:Dictionary;
		
		public static var instance:MessageManager = new MessageManager();
		
		public function MessageManager()
		{
		}
		
		public function initialize():void
		{
			mMsgDic = new Dictionary();
		}
		
		public function registerMessage():void
		{
			regMsg(103,MSG_RES_LOGIN_103);
			regMsg(105,MSG_RES_GET_RECOMMEND_SVR_LIST_105);
			regMsg(106,MSG_RES_GET_ROLE_INFO_106);
			regMsg(107,MSG_RES_CREATE_ROLE_107);
		}
		
		private function regMsg(mid:uint,MSG:Class):void
		{
			mMsgDic[mid] = MSG;
		}
		
		public function getMSG(mid:uint):Class
		{
			return mMsgDic[mid] as Class;
		}
		
		public function dispose():void
		{
			mMsgDic = null;
		}
	}
}
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
			regMsg(0x0001,MSG_RES_LOGIN_VERIFY_USER_0x0001);
			regMsg(0x9000,MSG_RES_ROLE_CREATE_ROLE_0x9000);
			regMsg(0x9001,MSG_RES_ROLE_EXIST_ROLE_0x9001);
			regMsg(0x6000,MSG_RES_SWITCH_WORLD_NOTIFY_USER_NUM_0x6000);
			regMsg(0x6001,MSG_RES_SWITCH_USER_VERIFY_DONE_0x6001);
			regMsg(0x6002,MSG_RES_SWITCH_USER_LEAVE_GATEWAY_0x6002);
			regMsg(0x6003,MSG_RES_SWITCH_USER_INTO_WORLD_0x6003);
			regMsg(0x6004,MSG_RES_SWITCH_GET_WORLD_LIST_0x6004);
			regMsg(0x6005,MSG_RES_SWITCH_USER_LEAVE_WORLD_0x6005);
			regMsg(0x6100,MSG_RES_WORLD_REQ_FRIEND_SIMPLE_INFO_0x6100);
			regMsg(0x6101,MSG_RES_WORLD_SEND_FRIEND_SIMPLE_INFO_0x6101);
			regMsg(0x6102,MSG_RES_WORLD_REQ_ZHUFU_0x6102);
			regMsg(0x6103,MSG_RES_WORLD_NOTIFY_RECV_ZHUFU_0x6103);
			
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
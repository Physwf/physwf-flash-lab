package com.physwf.components.rpc.events
{
	import com.physwf.components.rpc.msg.MsgBase;
	
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		public static const MSG_ERROR_:String = "m_e_";
		public static const MSG_SUCCESS_:String = "m_s_";
		
		private var mMsg:MsgBase;
		
		public function MessageEvent(type:String,msg:MsgBase)
		{
			super(type, false, false);
			mMsg = msg;
		}
		
		public function get message():MsgBase
		{
			return mMsg;
		}
	}
}
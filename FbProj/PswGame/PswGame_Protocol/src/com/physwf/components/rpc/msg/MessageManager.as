package com.physwf.components.rpc.msg
{
	import flash.utils.Dictionary;

	public class MessageManager
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
			regMsg(1000,MSG_RES_LOGIN_AND_ENTER_MAP_1000);
			regMsg(1001,MSG_RES_LOGIN_1001);
			regMsg(1002,MSG_RES_NOTIFY_KICK_USER_OFFLINE_1002);
			regMsg(1003,MSG_RES_DEL_FRIEND_1003);
			regMsg(1004,MSG_RES_ADD_FRIEND_1004);
			regMsg(1005,MSG_RES_ADD_TO_BLACKLIST_1005);
			regMsg(1006,MSG_RES_DEL_FROM_BLACKLIST_1006);
			regMsg(1007,MSG_RES_GET_RECOMMENDED_FRIENDS_LIST_1007);
			regMsg(1008,MSG_RES_SET_USER_FLAG_1008);
			regMsg(1009,MSG_RES_FRIEND_NOTIFY_ADDED_1009);
			regMsg(1010,MSG_RES_GET_FRIENDS_LIST_1010);
			regMsg(1011,MSG_RES_GET_BLACKLIST_1011);
			regMsg(1012,MSG_RES_GET_UNION_LIST_1012);
			regMsg(1013,MSG_RES_CHECK_ONLINE_USERS_1013);
			regMsg(1014,MSG_RES_GET_RECENTLY_CONTACTED_LIST_1014);
			regMsg(1015,MSG_RES_GET_USER_INFO_1015);
			regMsg(1016,MSG_RES_NOTIFY_SYS_TIME_1016);
			regMsg(1017,MSG_RES_CHAT_PRIVATE_MSG_1017);
			regMsg(1020,MSG_RES_OBTAIN_TASK_1020);
			regMsg(1021,MSG_RES_CANCEL_TASK_1021);
			regMsg(1022,MSG_RES_FINISH_TASK_1022);
			regMsg(1023,MSG_RES_GET_TASK_FLAG_LIST_1023);
			regMsg(1024,MSG_RES_GET_TASK_FULL_LIST_1024);
			regMsg(1025,MSG_RES_SETBUFF_TASK_1025);
			regMsg(1026,MSG_RES_GET_TASK_BUFF_LIST_1026);
			regMsg(1027,MSG_RES_TASK_QUERY_ABLE_1027);
			regMsg(1030,MSG_RES_ENTER_MAP_1030);
			regMsg(1031,MSG_RES_LEAVE_MAP_1031);
			regMsg(1032,MSG_RES_GET_MAP_USER_LIST_1032);
			regMsg(1033,MSG_RES_GET_MAP_USER_DETAIL_INFO_1033);
			regMsg(1034,MSG_RES_NOTI_ENTER_MAP_1034);
			regMsg(1035,MSG_RES_NOTI_LEAVE_MAP_1035);
			regMsg(1036,MSG_RES_MAP_PLAYER_MOVE_1036);
			regMsg(1037,MSG_RES_NOTI_USER_MOVE_1037);
			regMsg(1038,MSG_RES_GET_MAP_MONSTERS_1038);
			regMsg(1039,MSG_RES_NOTI_MAP_MONSTERS_1039);
			regMsg(1040,MSG_RES_BATTLE_ATTACK_1040);
			regMsg(1041,MSG_RES_NOTI_ATTACK_RESULT_1041);
			regMsg(1050,MSG_RES_GET_BAG_1050);
			regMsg(1060,MSG_RES_GET_PET_INFO_1060);
			regMsg(1061,MSG_RES_GET_BAG_PETS_1061);
			regMsg(5000,MSG_RESGATEWAY_REPORT_TO_MAPSERV_5000);
			regMsg(5001,MSG_RESGATEWAY_DEL_USER_5001);
			regMsg(5002,MSG_RESGATEWAY_CLOSE_CONN_5002);
		}
		
		private function regMsg(mid:uint,MSG:Class):void
		{
			mMsgDic[mid] = MSG;
		}
		
		public function getMSG(mid:uint):Class
		{
			return mMsgDic[mid] as Class;
		}
		
		public function setMsgUID(v:uint):void
		{
			MsgBase.UID = v;
		}
	}
}
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
			regMsg(1001,MSG_RES_LOGIN_1001);
			regMsg(1002,MSG_RES_NOTIFY_KICK_USER_OFFLINE_1002);
			regMsg(1010,MSG_RES_USER_LEVEL_UP_1010);
			regMsg(1029,MSG_RES_USER_WALK_PATH_1029);
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
			regMsg(1042,MSG_RES_NOTI_OBJ_DEAD_1042);
			regMsg(1050,MSG_RES_GET_BAG_1050);
			regMsg(1051,MSG_RES_DEL_ITEM_1051);
			regMsg(1052,MSG_RES_CHANGE_GRID_1052);
			regMsg(1053,MSG_RES_ADD_ITEM_1053);
			regMsg(1060,MSG_RES_GET_PET_INFO_1060);
			regMsg(1061,MSG_RES_GET_BAG_PETS_1061);
			regMsg(1062,MSG_RES_DEL_PET_1062);
			regMsg(1063,MSG_RES_SET_PET_FOLLOW_1063);
			regMsg(1064,MSG_RES_SET_PET_UNFOLLOW_1064);
			regMsg(1070,MSG_RES_DEL_FRIEND_1070);
			regMsg(1071,MSG_RES_ADD_FRIEND_1071);
			regMsg(1072,MSG_RES_ADD_TO_BLACKLIST_1072);
			regMsg(1073,MSG_RES_DEL_FROM_BLACKLIST_1073);
			regMsg(1074,MSG_RES_GET_RECOMMENDED_FRIENDS_LIST_1074);
			regMsg(1075,MSG_RES_SET_USER_FLAG_1075);
			regMsg(1076,MSG_RES_FRIEND_NOTIFY_ADDED_1076);
			regMsg(1077,MSG_RES_GET_FRIENDS_LIST_1077);
			regMsg(1078,MSG_RES_GET_BLACKLIST_1078);
			regMsg(1079,MSG_RES_GET_UNION_LIST_1079);
			regMsg(1080,MSG_RES_CHECK_ONLINE_USERS_1080);
			regMsg(1081,MSG_RES_GET_RECENTLY_CONTACTED_LIST_1081);
			regMsg(1082,MSG_RES_GET_USER_INFO_1082);
			regMsg(1083,MSG_RES_CHAT_PRIVATE_MSG_1083);
			regMsg(1091,MSG_RES_CHANGE_EQUIPS_1091);
			regMsg(1092,MSG_RES_DEL_EQUIP_1092);
			regMsg(1093,MSG_RES_NOTI_CHANGE_EQUIPS_1093);
			regMsg(1110,MSG_RES_OBTAIN_TASK_1110);
			regMsg(1111,MSG_RES_CANCEL_TASK_1111);
			regMsg(1112,MSG_RES_FINISH_TASK_1112);
			regMsg(1113,MSG_RES_GET_TASK_FLAG_LIST_1113);
			regMsg(1114,MSG_RES_GET_TASK_FULL_LIST_1114);
			regMsg(1115,MSG_RES_SETBUFF_TASK_1115);
			regMsg(1116,MSG_RES_GET_TASK_BUFF_LIST_1116);
			regMsg(1117,MSG_RES_TASK_QUERY_ABLE_1117);
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
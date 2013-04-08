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
			regMsg(1003,MSG_RES_GET_SYS_TIME_1003);
			regMsg(1010,MSG_RES_USER_LEVEL_UP_1010);
			regMsg(1011,MSG_RES_NOTI_ATTR_CHANGE_1011);
			regMsg(1012,MSG_RES_NOTI_EXP_MONEY_1012);
			regMsg(1028,MSG_RES_WALK_1028);
			regMsg(1029,MSG_RES_SYNC_POSITION_1029);
			regMsg(1030,MSG_RES_ENTER_MAP_1030);
			regMsg(1031,MSG_RES_LEAVE_MAP_1031);
			regMsg(1032,MSG_RES_GET_MAP_USER_LIST_1032);
			regMsg(1034,MSG_RES_NOTI_ENTER_MAP_1034);
			regMsg(1035,MSG_RES_NOTI_LEAVE_MAP_1035);
			regMsg(1036,MSG_RES_MAP_PLAYER_MOVE_1036);
			regMsg(1037,MSG_RES_NOTI_USER_MOVE_1037);
			regMsg(1038,MSG_RES_GET_MAP_MONSTERS_1038);
			regMsg(1039,MSG_RES_NOTI_MAP_MONSTERS_1039);
			regMsg(1040,MSG_RES_BATTLE_ATTACK_1040);
			regMsg(1041,MSG_RES_NOTI_ATTACK_RESULT_1041);
			regMsg(1042,MSG_RES_NOTI_OBJ_DEAD_1042);
			regMsg(1043,MSG_RES_NOTI_MONSTER_MOVE_1043);
			regMsg(1044,MSG_RES_NOTI_MONSTER_TALK_1044);
			regMsg(1045,MSG_RES_NOTI_USER_DEAD_TYPE_1045);
			regMsg(1046,MSG_RES_NOTI_USER_REBIRTH_1046);
			regMsg(1047,MSG_RES_NOTI_BUFF_INFO_1047);
			regMsg(1048,MSG_RES_SET_SKILL_CHANT_1048);
			regMsg(1050,MSG_RES_GET_BAG_1050);
			regMsg(1051,MSG_RES_DEL_ITEM_1051);
			regMsg(1052,MSG_RES_CHANGE_GRID_1052);
			regMsg(1053,MSG_RES_NOTI_BAG_GRID_1053);
			regMsg(1054,MSG_RES_ADD_HP_MP_1054);
			regMsg(1055,MSG_RES_NOTI_DROP_ITEM_1055);
			regMsg(1056,MSG_RES_PICK_UP_ITEM_1056);
			regMsg(1057,MSG_RES_USE_ITEM_REBIRTH_1057);
			regMsg(1058,MSG_RES_ADJUST_1058);
			regMsg(1060,MSG_RES_GET_PET_INFO_1060);
			regMsg(1061,MSG_RES_GET_BAG_PETS_1061);
			regMsg(1062,MSG_RES_DEL_PET_1062);
			regMsg(1063,MSG_RES_SET_PET_FOLLOW_1063);
			regMsg(1064,MSG_RES_SET_PET_UNFOLLOW_1064);
			regMsg(1065,MSG_RES_NOTI_PET_FOLLOW_1065);
			regMsg(1066,MSG_RES_PRODUCE_PET_1066);
			regMsg(1067,MSG_RES_NOTI_ADD_PET_1067);
			regMsg(1068,MSG_RES_CATCH_PET_1068);
			regMsg(1070,MSG_RES_DEL_FRIEND_1070);
			regMsg(1071,MSG_RES_ADD_FRIEND_1071);
			regMsg(1072,MSG_RES_ADD_TO_BLACKLIST_1072);
			regMsg(1073,MSG_RES_DEL_FROM_BLACKLIST_1073);
			regMsg(1074,MSG_RES_GET_RECOMMENDED_FRIENDS_LIST_1074);
			regMsg(1075,MSG_RES_SET_USER_FLAG_1075);
			regMsg(1076,MSG_RES_NOTI_ADD_FRIEND_1076);
			regMsg(1077,MSG_RES_GET_FRIENDS_LIST_1077);
			regMsg(1078,MSG_RES_GET_BLACKLIST_1078);
			regMsg(1079,MSG_RES_GET_UNION_LIST_1079);
			regMsg(1080,MSG_RES_CHECK_ONLINE_USERS_1080);
			regMsg(1081,MSG_RES_GET_RECENTLY_CONTACTED_LIST_1081);
			regMsg(1082,MSG_RES_GET_USER_ROLE_INFO_1082);
			regMsg(1083,MSG_RES_GET_FRIEND_SIMPLE_INFO_1083);
			regMsg(1084,MSG_RES_ADD_FRIEND_BY_NICK_1084);
			regMsg(1085,MSG_RES_CHAT_PRIVATE_MSG_1085);
			regMsg(1086,MSG_RES_CHAT_PUBLIC_MSG_1086);
			regMsg(1091,MSG_RES_CHANGE_EQUIPS_1091);
			regMsg(1092,MSG_RES_DEL_EQUIP_1092);
			regMsg(1093,MSG_RES_NOTI_CHANGE_EQUIPS_1093);
			regMsg(1094,MSG_RES_ADD_ITEM_1094);
			regMsg(1101,MSG_RES_GET_MAIL_HEAD_LIST_1101);
			regMsg(1102,MSG_RES_GET_MAIL_BODY_1102);
			regMsg(1103,MSG_RES_DEL_MAIL_1103);
			regMsg(1104,MSG_RES_TAKE_MAIL_ENCLOSUE_1104);
			regMsg(1105,MSG_RES_SEND_MAIL_1105);
			regMsg(1106,MSG_RES_NOTI_NEW_MAIL_1106);
			regMsg(1110,MSG_RES_OBTAIN_TASK_1110);
			regMsg(1111,MSG_RES_CANCEL_TASK_1111);
			regMsg(1112,MSG_RES_FINISH_TASK_1112);
			regMsg(1113,MSG_RES_GET_TASK_LIST_1113);
			regMsg(1114,MSG_RES_SET_TASK_STEP_1114);
			regMsg(1117,MSG_RES_TASK_QUERY_ABLE_1117);
			regMsg(1120,MSG_RES_ADD_SKILL_1120);
			regMsg(1121,MSG_RES_UPGRADE_SKILL_1121);
			regMsg(1122,MSG_RES_SET_USER_SHORTCUT_1122);
			regMsg(1130,MSG_RES_NOTI_HP_MP_1130);
			regMsg(5000,MSG_RESGATEWAY_REPORT_TO_MAPSERV_5000);
			regMsg(5001,MSG_RESGATEWAY_DEL_USER_5001);
			regMsg(5002,MSG_RESGATEWAY_CLOSE_CONN_5002);
			regMsg(5003,MSG_RESGATEWAY_SEND_MAIL_WITH_ENCLOSURE_5003);
			regMsg(5004,MSG_RESGATEWAY_TAKE_ENCLOSURE_5004);
			regMsg(5100,MSG_RESGATEWAY_NOTI_SEND_TO_MAP_5100);
			regMsg(5101,MSG_RESGATEWAY_UPDATE_SPRITE_DATA_5101);
			regMsg(5102,MSG_RESGATEWAY_ENTER_MAP_5102);
			regMsg(5103,MSG_RESGATEWAY_LEAVE_MAP_5103);
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
package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.System;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.vo.BagItemInfo;
	import com.physwf.system.vo.EquipInfo;
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.MapInfo;
	import com.physwf.system.vo.PetInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;

	public class MySelf extends EventDispatcher
	{
		/**
		 *登陆信息 
		 */		
		public static var loginInfo:LoginInfo = new LoginInfo();;
		/**
		 * 角色信息 
		 */		
		public static var userInfo:UserInfo = new UserInfo();
		/**
		 * 宠物信息 
		 */		
		public static var petInfo:PetInfo = new PetInfo();
		
		public function MySelf()
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1001,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1002,onMessage);
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1030,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1031,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1036,onMessage);//移动
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1091,onMessage);//换装
		}
		/**
		 * 登陆 
		 * 
		 */		
		public function login():void
		{
			var msg:MSG_REQ_LOGIN_1001 = new MSG_REQ_LOGIN_1001();
			msg.from_game = loginInfo.which_game;
			msg.to_game = loginInfo.which_game;
			msg.sess_data = loginInfo.session;
			var tempTad:ByteArray = new ByteArray();
			tempTad.length = 64;
			msg.tad_data = tempTad;
			msg.role_tm = loginInfo.roleInfo.createTime;
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 移动 
		 * @param x
		 * @param y
		 * @param dir
		 * 
		 */		
		public function move(x:uint,y:uint,dir:uint):void
		{
			var msg:MSG_REQ_MAP_PLAYER_MOVE_1036 = new MSG_REQ_MAP_PLAYER_MOVE_1036();
			msg.x = x;
			msg.y = y;
			msg.dir = dir;
//			dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 进入地图 
		 * @param mapid
		 * @param x
		 * @param y
		 * 
		 */		
		public function enterMap(mapid:uint,x:uint,y:uint):void
		{
			var msg:MSG_REQ_ENTER_MAP_1030 = new MSG_REQ_ENTER_MAP_1030();
			msg.role_tm = userInfo.createTime;
			msg.map_id = mapid;
			msg.map_x = x;
			msg.map_y = y;
			RPCConnectioin.online.call(msg);
		}
		/**
		 *离开当前地图 
		 * 
		 */		
		public function leaveMap():void
		{
			RPCConnectioin.online.call(new MSG_REQ_LEAVE_MAP_1031());
		}
		
		public function changeEquips():void
		{
			var msg:MSG_REQ_CHANGE_EQUIPS_1091 = new MSG_REQ_CHANGE_EQUIPS_1091();
			msg
		}
		
		public function syncPosition(x:uint,y:uint):void
		{
			var time:uint = System.systemTime;
			var msg:MSG_REQ_SYNC_POSITION_1029 = new MSG_REQ_SYNC_POSITION_1029();
			msg.timestamp = time;
			var pos:map_pos_t = new map_pos_t();
			pos.map_x = x;
			pos.map_y = y;
			msg.postions = pos;
			RPCConnectioin.online.call(msg);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1001://登录成功
					userInfo.createTime = loginInfo.roleInfo.createTime;
					var msg1001:MSG_RES_LOGIN_1001 = msg as MSG_RES_LOGIN_1001;
					userInfo.level = msg1001.user.level;
					userInfo.exp = msg1001.user.exp;
					userInfo.map_id = msg1001.user.map_id;
					userInfo.map_x = msg1001.user.map_x;
					userInfo.map_y = msg1001.user.map_y;
					userInfo.resource_id = msg1001.user.role_sex;
					userInfo.strength = msg1001.user.strength;
					userInfo.physical = msg1001.user.physique;
					userInfo.hp = msg1001.user.hp;
					userInfo.mp = msg1001.user.mp;
					userInfo.energy = msg1001.user.energy;
					userInfo.hp_max = msg1001.user.hp_max;
					userInfo.attack = msg1001.user.level;
					dispatchEvent(new MyEvent(MyEvent.LOGIN_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1002://被踢下线
					dispatchEvent(new MyEvent(MyEvent.KICKED_OFF));
					break;
				case MessageEvent.MSG_SUCCESS_+1030://进入地图
					var msg1030:MSG_RES_ENTER_MAP_1030 = MSG_RES_ENTER_MAP_1030(msg);
					petInfo.id = msg1030.user.pet_follow.instance_id;
					petInfo.type = msg1030.user.pet_follow.pet_id;
					petInfo.nick = msg1030.user.pet_follow.nick;
					petInfo.level = msg1030.user.pet_follow.level;
					petInfo.hp = msg1030.user.pet_follow.hp;
					petInfo.mp = msg1030.user.pet_follow.mp;
					var equipList:Vector.<uint> = msg1030.user.equips;
					var bagItems:Vector.<BagItemInfo> = System.bag.bagItems;
					for(var i:int=0;i<equipList.length;++i)
					{
						var equipInfo:EquipInfo = new EquipInfo();
						equipInfo.itemID = equipList[i];
						userInfo.equips.push(equipInfo);
					}
					dispatchEvent(new MyEvent(MyEvent.ENTER_MAP_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1031://离开地图
					break;
				case MessageEvent.MSG_SUCCESS_+1036://移动
					dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
					break;
				case MessageEvent.MSG_SUCCESS_+1091://换装
					dispatchEvent(new MyEvent(MyEvent.CHANGE_EQUIPS));
					break;
			}
		}
	}
}
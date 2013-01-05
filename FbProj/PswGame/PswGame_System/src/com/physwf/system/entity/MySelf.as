package com.physwf.system.entity
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.events.MyEvent;
	import com.physwf.system.vo.EquipInfo;
	import com.physwf.system.vo.LoginInfo;
	import com.physwf.system.vo.MapInfo;
	import com.physwf.system.vo.PetInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;

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
		/**
		 * 装备信息 
		 */		
		public static var equips:Vector.<EquipInfo> = new <EquipInfo>[];
		
		public function MySelf()
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1001,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1002,onMessage);
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1030,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1031,onMessage);
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1036,onMessage);
		}
		/**
		 * 登陆 
		 * 
		 */		
		public function login():void
		{
			var msg:MSG_REQ_LOGIN_1001 = new MSG_REQ_LOGIN_1001();
			msg.from_game = loginInfo.which_game;
			msg.to_game = 0;
			msg.sess = loginInfo.session;
			msg.tad = loginInfo.tad;
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
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1001://登录成功
					var msg1001:MSG_RES_LOGIN_1001 = msg as MSG_RES_LOGIN_1001;
					userInfo.level = msg1001.level;
					userInfo.exp = msg1001.exp;
					userInfo.map_id = msg1001.map_id;
					userInfo.map_x = msg1001.map_x;
					userInfo.map_y = msg1001.map_y;
					userInfo.resource_id = msg1001.resource_id;
					userInfo.strength = msg1001.strength;
					userInfo.intelligence = msg1001.intelligence;
					userInfo.physical = msg1001.physical;
					userInfo.magic = msg1001.magic;
					userInfo.speed = msg1001.speed;
					userInfo.additions = msg1001.additions;
					userInfo.hp = msg1001.hp;
					userInfo.mp = msg1001.mp;
					userInfo.energy = msg1001.energy;
					userInfo.hp_max = msg1001.hp_max;
					userInfo.attack = msg1001.level;
					userInfo.mattack = msg1001.mattack;
					userInfo.defense = msg1001.defense;
					userInfo.mdefence = msg1001.mdefense;
					userInfo.hit = msg1001.hit;
					userInfo.avoid = msg1001.avoid;
					userInfo.multiattack = msg1001.multi_attack;
					userInfo.multiavoid = msg1001.multi_avoid;
					dispatchEvent(new MyEvent(MyEvent.LOGIN_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1002://被踢下线
					dispatchEvent(new MyEvent(MyEvent.KICKED_OFF));
					break;
				case MessageEvent.MSG_SUCCESS_+1030://进入地图
					var msg1030:MSG_RES_ENTER_MAP_1030 = MSG_RES_ENTER_MAP_1030(msg);
					petInfo.id = msg1030.user.pet_follow.petid;
					petInfo.type = msg1030.user.pet_follow.pettype;
					petInfo.nick = msg1030.user.pet_follow.nick;
					petInfo.level = msg1030.user.pet_follow.level;
					petInfo.hp = msg1030.user.pet_follow.hp;
					petInfo.mp = msg1030.user.pet_follow.mp;
					var equipList:Vector.<stru_equip_simple_t> = msg1030.user.equips;
					for(var i:int=0;i<equipList.length;++i)
					{
						var equipInfo:EquipInfo = new EquipInfo();
						equipInfo.id = equipList[i].equip_id;
						equips.push(equipInfo);
					}
					dispatchEvent(new MyEvent(MyEvent.ENTER_MAP_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1031://离开地图
					break;
				case MessageEvent.MSG_SUCCESS_+1036://移动
					break;
			}
		}
	}
}
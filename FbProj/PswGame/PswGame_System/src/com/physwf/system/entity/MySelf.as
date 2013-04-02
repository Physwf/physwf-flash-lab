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
	import com.physwf.system.vo.SkillInfo;
	import com.physwf.system.vo.UserInfo;
	
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import mx.messaging.AbstractConsumer;

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
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1028,onMessage);//移动
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1030,onMessage);//进入地图
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1031,onMessage);//离开地图
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1036,onMessage);//移动old
			
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1091,onMessage);//换装
			
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1012,onMessage);//经验金钱 变化
			
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
		 * 移动 old
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
			dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 玩家移动
		 * @param timeStap
		 * @param path
		 * 
		 */		
		public function walkAlong(timeStap:uint,path:Vector.<uint>):void
		{
			var msg:MSG_REQ_WALK_1028 = new MSG_REQ_WALK_1028();
			msg.timestamp;
			msg.type = 0;//0 人 1 宠
			msg.postions = new Vector.<map_pos_t>();
			for(var i:uint=0;i<path.length;i+=2)
			{
				var p:map_pos_t = new map_pos_t();
				p.map_x = path[2*i];
				p.map_y = path[2*i+1]
				msg.postions.push(p);
			}
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
			msg.postion = pos;
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
					userInfo.nick = msg1001.user.nick;
					userInfo.level = msg1001.user.level;
					userInfo.prof = msg1001.user.prof;
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
					var skills:Vector.<SkillInfo> = new Vector.<SkillInfo>();
					for(i=0;i<msg1001.skills.length;++i)
					{
						var sInfo:SkillInfo = new SkillInfo();
						sInfo.id = msg1001.skills[i].skill_id;
						sInfo.level = msg1001.skills[i].skill_lv;
						skills.push(sInfo);
					}
					System.skill.skills = skills;
					System.skill.shortcutSkill = msg1001.skill_shortcut;
					dispatchEvent(new MyEvent(MyEvent.LOGIN_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1002://被踢下线
					dispatchEvent(new MyEvent(MyEvent.KICKED_OFF));
					break;
				case MessageEvent.MSG_SUCCESS_+1028://移动
					var msg1028:MSG_RES_WALK_1028 = e.message as MSG_RES_WALK_1028;
					var positions:Vector.<map_pos_t> = msg1028.postions;
					var path:Vector.<uint> = new Vector.<uint>();
					for(i=0;i<positions.length;++i)
					{
						path.push(positions[i].map_x,positions[i].map_y);
					}
					userInfo.path = path;
					dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
					break;
				case MessageEvent.MSG_SUCCESS_+1030://进入地图
					var msg1030:MSG_RES_ENTER_MAP_1030 = MSG_RES_ENTER_MAP_1030(msg);
					var user:map_user_info = msg1030.user;
					var pet_follow:stru_pet_simple_t = msg1030.user.pet_follow;
					
					userInfo.map_id = user.mapid;
					userInfo.map_x = user.map_x;
					userInfo.map_y = user.map_y;
					userInfo.hp = user.hp;
					userInfo.hp_max = user.hp_max;
					userInfo.mp = user.mp;
					userInfo.mp_max = user.mp_max;
					
					petInfo.id = pet_follow.instance_id;
					petInfo.type = pet_follow.pet_id;
					petInfo.nick = pet_follow.nick;
					petInfo.level = pet_follow.level;
					petInfo.hp = pet_follow.hp;
					petInfo.mp = pet_follow.mp;
					
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
					dispatchEvent(new MyEvent(MyEvent.LEAVE_MAP_SUCCESS));
					break;
				case MessageEvent.MSG_SUCCESS_+1036://移动
					dispatchEvent(new MyEvent(MyEvent.SELF_MOVE_ALLOWED));
					break;
				case MessageEvent.MSG_SUCCESS_+1091://换装
					dispatchEvent(new MyEvent(MyEvent.CHANGE_EQUIPS));
					break;
				case MessageEvent.MSG_SUCCESS_+1012:
					var msg1021:MSG_RES_NOTI_EXP_MONEY_1012 = e.message as MSG_RES_NOTI_EXP_MONEY_1012;
					userInfo.exp = msg1021.exp;
					userInfo.money = msg1021.money;
					dispatchEvent(new MyEvent(MyEvent.EXP_MONEY_CHANGE));
					break;
			}
		}
	}
}
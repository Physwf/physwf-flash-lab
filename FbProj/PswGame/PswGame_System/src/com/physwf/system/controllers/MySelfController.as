package com.physwf.system.controllers
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.components.rpc.msg.MsgBase;
	import com.physwf.system.entity.MySelf;

	public class MySelfController
	{
		private var mySelf:MySelf;
		
		public function MySelfController(model:MySelf)
		{
			mySelf = model;
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1001,onMessage);
		}
		
		private function onMessage(e:MessageEvent):void
		{
			var msg:MsgBase = e.message;
			
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1001://登录成功
					var msg1001:MSG_RES_LOGIN_1001 = msg as MSG_RES_LOGIN_1001;
					MySelf.userInfo.level = msg1001.level;
					MySelf.userInfo.exp = msg1001.exp;
					MySelf.userInfo.map_id = msg1001.map_id;
					MySelf.userInfo.map_x = msg1001.map_x;
					MySelf.userInfo.map_y = msg1001.map_y;
					MySelf.userInfo.resource_id = msg1001.resource_id;
					MySelf.userInfo.strength = msg1001.strength;
					MySelf.userInfo.intelligence = msg1001.intelligence;
					MySelf.userInfo.physical = msg1001.physical;
					MySelf.userInfo.magic = msg1001.magic;
					MySelf.userInfo.speed = msg1001.speed;
					MySelf.userInfo.additions = msg1001.additions;
					MySelf.userInfo.hp = msg1001.hp;
					MySelf.userInfo.mp = msg1001.mp;
					MySelf.userInfo.energy = msg1001.energy;
					MySelf.userInfo.hp_max = msg1001.hp_max;
					MySelf.userInfo.attack = msg1001.level;
					MySelf.userInfo.mattack = msg1001.mattack;
					MySelf.userInfo.defense = msg1001.defense;
					MySelf.userInfo.mdefence = msg1001.mdefense;
					MySelf.userInfo.hit = msg1001.hit;
					MySelf.userInfo.avoid = msg1001.avoid;
					MySelf.userInfo.multiattack = msg1001.multi_attack;
					MySelf.userInfo.multiavoid = msg1001.multi_avoid;
					break;
			}
		}
	}
}
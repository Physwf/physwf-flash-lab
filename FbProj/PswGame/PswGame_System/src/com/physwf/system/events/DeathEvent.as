package com.physwf.system.events
{
	import flash.events.Event;
	/**
	 * 主角死亡事件 
	 * @author joe
	 * 
	 */	
	public class DeathEvent extends Event
	{
		public static const SELF_DEATH:String = "s_d";
		
		private var mType:uint;//1新手死亡	2普通死亡	3切磋死亡	4比武场死亡 5 红名死亡
		private var mSrcId:uint//;攻击者id
		private var mSrcType:uint;//攻击者类型 攻击者类型 1人 2 宠物 3怪物 4npc
		private var mMoneyLose:uint;//金钱损失
		private var mExpLose:uint;//经验损失
		private var mDurationLose:uint;//耐久損失
		
		public function DeathEvent(type:String, deathType:uint, srcId:uint, srcType:uint, moneyLose:uint, expLose:uint, durationLose:uint )
		{
			mType = deathType;
			mSrcId = srcId;
			mSrcType = srcType;
			mMoneyLose = moneyLose;
			mExpLose = expLose;
			mDurationLose = durationLose;
			super(type, false, false);
		}
		
		public function get deathType():uint { return mType; }
		public function get srcId():uint { return mSrcId; }
		public function get srcType():uint { return mSrcType; }
		public function get moneyLose():uint { return mMoneyLose; }
		public function get expLose():uint { return mExpLose; }
		public function get duratioinLose():uint { return mDurationLose; }
	}
}
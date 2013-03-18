package com.physwf.system.vo
{
	public class SkillInfo
	{
		public var id:uint;
		public var name:String;
		public var range:uint;//预存为平方值
		public var singType:uint;//吟唱类型 0:不需要吟唱，1:需要吟唱
		public var effectId:uint;//对应的特效id
		
		public function SkillInfo()
		{
			
		}
	}
}
package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_SWITCH_GET_WORLD_LIST_0x6004 extends MsgBase
	{
		public var world_cnt:uint;
		public var worlds:Vector.<world_user_cnt_info_t>;
		
		public function MSG_RES_SWITCH_GET_WORLD_LIST_0x6004(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			world_cnt = input.readUnsignedInt();
			var worldsLen:uint =input.readUnsignedInt();
			worlds= new Vector.<world_user_cnt_info_t>();
			for(var i:uint=0;i<worldsLen;i++)
			{
				var worlds_item:world_user_cnt_info_t = new world_user_cnt_info_t()
				worlds_item.readExternal(input);;
				worlds.push(worlds_item);
			}			
		}
	}
}
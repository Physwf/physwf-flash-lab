package com.physwf.application.login.msg
{
	
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_RECOMMEND_SVR_LIST_105 extends MsgBase
	{
		public var recommend_svr_list:Vector.<recommend_area_list_t>;
		
		public function MSG_RES_GET_RECOMMEND_SVR_LIST_105(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			var recommend_svr_listLen:uint =input.readUnsignedInt();
			recommend_svr_list= new Vector.<recommend_area_list_t>();
			for(var i:int=0;i<recommend_svr_listLen;++i)
			{
				var item:recommend_area_list_t = new recommend_area_list_t()
				item.readExternal(input);;
				recommend_svr_list.push(item);
			}			
		}
	}
}
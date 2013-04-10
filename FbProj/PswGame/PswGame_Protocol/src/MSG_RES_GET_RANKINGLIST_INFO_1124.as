package 
{
	import com.physwf.components.rpc.msg.MsgBase
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.ByteArray;
	
	final public class MSG_RES_GET_RANKINGLIST_INFO_1124 extends MsgBase
	{
		public var ranking_type:uint;
		public var score_list:Vector.<score_item_t>;
		public var self_score_list:Vector.<score_index_item_t>;
		
		public function MSG_RES_GET_RANKINGLIST_INFO_1124(mid:uint)
		{
			super(mid);
		}
		
		override protected function readBody(input:IDataInput):void
		{
			ranking_type = input.readUnsignedInt();
			var score_listLen:uint =input.readUnsignedInt();
			score_list= new Vector.<score_item_t>();
			for(var i:int=0;i<score_listLen;++i)
			{
				var score_list_item:score_item_t = new score_item_t()
				score_list_item.readExternal(input);;
				score_list.push(score_list_item);
			}
			var self_score_listLen:uint =input.readUnsignedInt();
			self_score_list= new Vector.<score_index_item_t>();
			for(var j:int=0;j<self_score_listLen;++j)
			{
				var self_score_list_item:score_index_item_t = new score_index_item_t()
				self_score_list_item.readExternal(input);;
				self_score_list.push(self_score_list_item);
			}			
		}
	}
}
package com.physwf.engine.common.ds
{
	import flash.utils.Dictionary;
	/**
	 * 索引查询字典，通过数据id来查询对应的所在数组中的索引 
	 * @author Physwf
	 * 
	 */
	public class DC
	{
		public static var player:DC = new DC();
		public static var npc:DC = new DC();
		public static var monster:DC = new DC();
		
		private var dic:Dictionary;
		
		public function DC()
		{
			dic = new Dictionary();
		}
		
		public function insert(id:uint,index:uint):Boolean
		{
			if(dic[id]) return false;
			
			dic[id] = index;
			return true;
		}
		
		public function find(id:uint):uint
		{
			return dic[id] as uint;
		}
		
		public function remove(id:uint):uint
		{
			var ret:uint = dic[id] as uint;
			delete dic[id]
			return ret;
		}
	}
}
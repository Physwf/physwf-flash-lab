package com.physwf.system.events
{
	import com.physwf.system.vo.TaskInfo;
	
	import flash.events.Event;
	
	public class TaskEvent extends Event
	{
		public static const TASK_LIST:String = "t_l";
		public static const TASK_OBTAINED:String = "t_a";
		public static const TASK_CANCELED:String = "t_c";
		public static const TASK_FINISHED:String = "t_f";
		public static const TASK_SET_STEP:String = "t_s_s";
		public static const TASK_SET_QUARYABLE:String = "t_s_q";
		
		private var mInfo:TaskInfo;
		
		public function TaskEvent(type:String, info:TaskInfo)
		{
			mInfo = info;
			super(type, false, false);
		}
		
		public function get info():TaskInfo
		{
			return mInfo;
		}
	}
}
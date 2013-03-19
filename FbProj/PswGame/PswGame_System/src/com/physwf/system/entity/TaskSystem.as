package com.physwf.system.entity 
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	
	import flash.events.EventDispatcher;

	public class TaskSystem extends EventDispatcher
	{
		public function TaskSystem() 
		{
			
		}
		
		public function initialize():void
		{
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1110,onMessageEvent);//接任务
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1111,onMessageEvent);//放弃任务
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1112,onMessageEvent);//完成任务
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1113,onMessageEvent);//获取任务flag列表
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1114,onMessageEvent);//客户端设置任务步骤状态
			RPCConnectioin.online.addEventListener(MessageEvent.MSG_SUCCESS_+1117,onMessageEvent);//任务使能查询
		}
		
		public function getTaskList():void
		{
			var msg:MSG_REQ_GET_TASK_LIST_1113 = new MSG_REQ_GET_TASK_LIST_1113();
			// to do 参数
			RPCConnectioin.online.call(msg);
		}
		
		public function obtaiTask(taskId:uint):void
		{
			var msg:MSG_REQ_OBTAIN_TASK_1110 = new MSG_REQ_OBTAIN_TASK_1110();
			msg.tskid = taskId;
			RPCConnectioin.online.call(msg);
		}
		
		public function cancelTask(taskId:uint):void
		{
			var msg:MSG_REQ_CANCEL_TASK_1111 = new MSG_REQ_CANCEL_TASK_1111();
			msg.tskid = taskId;
			RPCConnectioin.online.call(msg);
		}
		
		public function finishTask(taskId:uint,optionalPos:uint):void
		{
			var msg:MSG_REQ_FINISH_TASK_1112 = new MSG_REQ_FINISH_TASK_1112();
			msg.tskid = taskId;
			msg.optional_pos = optionalPos;
			RPCConnectioin.online.call(msg);
		}
		
		public function setTaskStep(taskId:uint,step:uint):void
		{
			var msg:MSG_REQ_SET_TASK_STEP_1114 = new MSG_REQ_SET_TASK_STEP_1114();
			msg.tskid = taskId;
			msg.step = step;
			RPCConnectioin.online.call(msg);
		}
		/**
		 * 
		 * @param type 1: obtain; 其它的查询暂不支持 
		 * @param taskIdList 任务id列表
		 * 
		 */		
		public function enableTaskQuery(type:uint,taskIdList:Vector.<uint>):void
		{
			var msg:MSG_REQ_TASK_QUERY_ABLE_1117 = new MSG_REQ_TASK_QUERY_ABLE_1117();
			msg.query_type = type;
			msg.tskid_list = taskIdList;
			RPCConnectioin.online.call(msg);
		}
		
		private function onMessageEvent(e:MessageEvent):void
		{
			switch(e.type)
			{
				case MessageEvent.MSG_SUCCESS_+1110:
					break;
				case MessageEvent.MSG_SUCCESS_+1111:
					break;
				case MessageEvent.MSG_SUCCESS_+1112:
					break;
				case MessageEvent.MSG_SUCCESS_+1113:
					break;
				case MessageEvent.MSG_SUCCESS_+1114:
					break;
				case MessageEvent.MSG_SUCCESS_+1117:
					break;
			}
		}

	} // end class
} // end package
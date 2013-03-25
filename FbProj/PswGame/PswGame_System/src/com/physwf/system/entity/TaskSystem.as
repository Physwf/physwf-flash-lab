package com.physwf.system.entity 
{
	import com.physwf.components.rpc.RPCConnectioin;
	import com.physwf.components.rpc.events.MessageEvent;
	import com.physwf.system.events.TaskEvent;
	import com.physwf.system.vo.TaskInfo;
	import com.physwf.system.vo.TaskStepInfo;
	
	import flash.events.EventDispatcher;

	public class TaskSystem extends EventDispatcher
	{
		private var mTaskList:Vector.<TaskInfo>;
		
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
		
		public function getTaskList(beginId:uint,endId:uint):void
		{
			var msg:MSG_REQ_GET_TASK_LIST_1113 = new MSG_REQ_GET_TASK_LIST_1113();
			// to do 参数
			msg.begin_tskid = beginId;
			msg.end_tskid = endId;
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
				case MessageEvent.MSG_SUCCESS_+1110://接任务
					var msg1110:MSG_RES_OBTAIN_TASK_1110 = e.message as MSG_RES_OBTAIN_TASK_1110;
					var tInfo:TaskInfo = getTaskInfo(msg1110.tskid);
					dispatchEvent(new TaskEvent(TaskEvent.TASK_OBTAINED,tInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1111://放弃任务
					var msg1111:MSG_RES_CANCEL_TASK_1111 = e.message as MSG_RES_CANCEL_TASK_1111;
					tInfo = getTaskInfo(msg1111.tskid);
					dispatchEvent(new TaskEvent(TaskEvent.TASK_CANCELED,tInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1112://完成任务
					var msg1112:MSG_RES_FINISH_TASK_1112 = e.message as MSG_RES_FINISH_TASK_1112;
					tInfo = getTaskInfo(msg1112.tskid);
					dispatchEvent(new TaskEvent(TaskEvent.TASK_FINISHED,tInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1113:
					mTaskList = new Vector.<TaskInfo>();
					var msg1113:MSG_RES_GET_TASK_LIST_1113 = e.message as MSG_RES_GET_TASK_LIST_1113;
					for(var i:uint=0;i<msg1113.tasks.length;++i)
					{
						tInfo = new TaskInfo();
						tInfo.id = msg1113.tasks[i].task_id;
						tInfo.flag = msg1113.tasks[i].flag;
						var steps:Vector.<stru_task_step_t> = msg1113.tasks[i].steps;
						tInfo.stepInfo = new Vector.<TaskStepInfo>();
						for(var j:uint=0;j<steps.length;++j)
						{
							var sInfo:TaskStepInfo = new TaskStepInfo();
							sInfo.flag = steps[i].flag;
							sInfo.step = steps[i].step;
							sInfo.value = steps[i].value;
							tInfo.stepInfo.push(sInfo);
						}
					}
					dispatchEvent(new TaskEvent(TaskEvent.TASK_LIST,null));
					break;
				case MessageEvent.MSG_SUCCESS_+1114://客户端设置任务步骤状态
					var msg1114:MSG_RES_SET_TASK_STEP_1114 = e.message as MSG_RES_SET_TASK_STEP_1114;
					tInfo = getTaskInfo(msg1114.tskid);
					//to do
					//tInfo.stepInfo. 
					dispatchEvent(new TaskEvent(TaskEvent.TASK_SET_STEP,tInfo));
					break;
				case MessageEvent.MSG_SUCCESS_+1117://任务使能查询
					var msg1117:MSG_RES_TASK_QUERY_ABLE_1117 = e.message as MSG_RES_TASK_QUERY_ABLE_1117;
					// to do
					break;
			}
		}
		
		private function getTaskInfo(id:uint):TaskInfo
		{
			for(var i:uint=0;i<mTaskList.length;++i)
			{
				if(mTaskList[i].id == id) return mTaskList[i];
			}
			return null;
		}

	} // end class
} // end package
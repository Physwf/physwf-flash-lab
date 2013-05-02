package com.physwf.components
{
	import com.physwf.components.interfaces.IExecutable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 *event manager 
	 * @author Physwf
	 * 
	 */	
	public class EM
	{
		private static var wraperQueue:Vector.<IExecutable> = new Vector.<IExecutable>();
		private static var listenerLib:Dictionary = new Dictionary();
		
		public function EM()
		{
		}
		
		public static function addListener(target:EventDispatcher,type:String,listener:Function):void
		{
			//to do 考虑冒泡事件  priority
			if(!listenerLib[target])
				listenerLib[target] = new Dictionary();
			listenerLib[target][type] = listener;
			
			target.addEventListener(type,wrapListener);
		}
		
		public static function removeListener(target:EventDispatcher,type:String,listener:Function):void
		{
			if(!listenerLib[target]) return;
			target.removeEventListener(type,wrapListener);
			delete listenerLib[target][type];
		}
		
		private static function wrapListener(e:Event):void
		{
			var litener:Function = getListener(e.target,e.type);
			var wraper:ListenerWraper = new ListenerWraper(litener,e);
			wraperQueue.push(wraper);
		}
		
		private static function getListener(target:Object,type:String):Function
		{
			if(!listenerLib[target]) 
				throw "该对象未注册任何事件侦听！";
			if(!listenerLib[target][type])
				throw "该对象未注册"+type+"事件类型的侦听！";
			return listenerLib[target][type];
		}
		
		public static var limit:uint = 10;
		public static function exexute():void
		{
			//to do 添加时间判定
			if(!wraperQueue.length) return;
			var beforeExe:uint = getTimer();
			while(wraperQueue.length)
			{
				var wraper:IExecutable = wraperQueue.shift();
				wraper.execute();
				if(getTimer() - beforeExe>limit) break;
			}
			
		}
	}
}



import com.physwf.components.interfaces.IExecutable;

import flash.events.Event;

class ListenerWraper implements IExecutable
{
	private var _listener:Function;
	private var _param:Event;
	
	public function ListenerWraper(listener:Function,param:Event)
	{
		_listener = listener;
		_param = param;
	}
	public function execute():void
	{
		_listener(_param);
	}
}
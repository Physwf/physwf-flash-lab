package com.physwf.application.login.view
{
	import com.physwf.application.login.cache.OnlineInfo;
	import com.physwf.system.vo.ServerInfo;
	
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.OverflowPolicy;

	public class SelectAreaPanel extends PanelBase
	{
		public var onAreaSelected:Function;
		private var areaSelected:uint;
		
		public function SelectAreaPanel(assetName:String)
		{
			super(assetName);
			asset.x = 500;
			asset.y = 250;
			for(var i:int=0;i<3;++i)
			{
				asset["mcArea"+i].mouseChildren = false;
				asset["mcArea"+i].buttonMode = true;
			}
		}
		
		public function setAreas(areas:Vector.<ServerInfo>):void
		{
			for(var i:int=0;i<areas.length;++i)
			{
				asset["mcArea"+i]["txtArea"].text = areas[i].area_id+":"+areas[i].ip;
			}
		}
		
		public function getSelectArea():ServerInfo
		{
			return OnlineInfo.onlines[areaSelected];
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "mcArea0":
				case "mcArea1":
				case "mcArea2":
					areaSelected = e.target.name.charAt(6);
					onAreaSelected();
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			onAreaSelected = null;
		}
	}
}
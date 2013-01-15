package com.physwf.application.login.view
{
	import com.physwf.application.login.cache.OnlineInfo;
	import com.physwf.system.vo.RoleInfo;
	
	import flash.events.MouseEvent;

	public class SelectRolePanel extends PanelBase
	{
		public var onRoleSelected:Function;
		
		private var roleSelectedID:uint;
		
		public function SelectRolePanel(assetName:String)
		{
			super(assetName);
			asset.x = 500;
			asset.y = 250;
			for(var i:int=0;i<3;++i)
			{
				asset["mcRole"+i].mouseChildren = false;
				asset["mcRole"+i].buttonMode = true;
			}
		}
		
		public function getRoleSelected():RoleInfo
		{
			return OnlineInfo.roles[roleSelectedID];
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "mcRole0":
				case "mcRole1":
				case "mcRole2":
					roleSelectedID = uint(e.target.name.charAt(6));
					onRoleSelected();
					break;
			}
		}
		
		public function setRoles(roles:Vector.<RoleInfo>):void
		{
			for(var i:int =0;i<roles.length;++i)
			{
				asset["mcRole"+i]["txtNick"].text = roles[i].nick;
				asset["mcRole"+i]["txtSex"].text = roles[i].prof;
				asset["mcRole"+i]["txtBirthDay"].text = roles[i].createTime;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			onRoleSelected = null;
		}
	}
}
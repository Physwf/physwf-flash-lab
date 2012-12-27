package com.physwf.application.login.view
{
	import flash.events.MouseEvent;
	
	public class SignInPanel extends PanelBase
	{
		public var onSignIn:Function;
		public var onRegister:Function;
		
		public function SignInPanel(assetName:String)
		{
			super(assetName);
		}
		
		override protected function onClick(e:MouseEvent):void
		{
			switch(e.target.name)
			{
				case "btnSignIn":
					break;
			}
		}
		
		public function get userID():String
		{
			return null;
		}
		
		public function get password():String
		{
			return null;
		}
	}
}
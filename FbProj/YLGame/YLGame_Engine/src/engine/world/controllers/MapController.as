package engine.world.controllers
{
	import flash.events.MouseEvent;
	
	import components.command.LinerCmdSequence;
	import components.map.MapView;
	
	import engine.common.command.CmdGoTo;
	import engine.common.command.CmdStand;
	import engine.world.objects.Character;
	
	public class MapController
	{
		public static var instance:MapController = new MapController();
		
		private var mapView:MapView;
		public var targetX:Number;
		public var targetY:Number;
		
		public function MapController()
		{
		}
		
		public function initialize(view:MapView):void
		{
			mapView = view;
			mapView.stage.addEventListener(MouseEvent.CLICK,onGroundClick);
//			mapView.bottom.addEventListener(MouseEvent.MOUSE_DOWN,onGroundDown);
//			mapView.bottom.addEventListener(MouseEvent.MOUSE_UP,onGroundUp);
		}
		
		private function onGroundClick(e:MouseEvent):void
		{
			targetX = mapView.mouseX;
			targetY = mapView.mouseY;
			var cmdGoto:CmdGoTo = new CmdGoTo(Character.self);
			cmdGoto.setDest(targetX,targetY);
			var stand:CmdStand = new CmdStand(Character.self);
			var seq:LinerCmdSequence = new LinerCmdSequence();
			seq.addCommand(cmdGoto);
			seq.addCommand(stand);
			Character.self.execute(seq);
		}
		
		private function onGroundDown(e:MouseEvent):void
		{
			mapView.startDrag();
		}
		
		private function onGroundUp(e:MouseEvent):void
		{
			mapView.stopDrag();
		}
		
		public function getMapID():uint
		{
			return 0;
		}
	}
}
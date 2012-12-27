package psw2d
{
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import psw2d.core.Context2D;
	import psw2d.display.DisplayObject;
	import psw2d.display.Stage;
	import psw2d.display.animation.AnimationMaster;
	import psw2d.render.ImageRender;
	import psw2d.render.QuadRender;
	import psw2d.render.RenderBase;
	import psw2d.render.RenderMaster;

	public class Alcedo extends EventDispatcher
	{
		private var _nativeStage:flash.display.Stage;
		private var _stage3D:Stage3D;
		private var _rootClass:Class;
		
		private var _context:Context2D;
		private var _stage:psw2d.display.Stage;
		private var _renderMaster:RenderMaster;
		private var _animaMaster:AnimationMaster;
		
		private static var _instance:Alcedo;
		
		private var _started:Boolean = false;
		
		public function Alcedo(rootClass:Class,
								stage:flash.display.Stage,
								stage3D:Stage3D)
		{
			_nativeStage = stage;
			_stage3D = stage3D;
			_rootClass = rootClass;
			
			_renderMaster = new RenderMaster();
			_animaMaster = new AnimationMaster();
			
			_renderMaster.setOrthographicProjection(stage.stageWidth,stage.stageHeight);
			
			_stage = new psw2d.display.Stage(_nativeStage.stageWidth,_nativeStage.stageHeight,_nativeStage.color);
			_nativeStage.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			requestContext2D();
		}
		
		
		private function init():void
		{
			_instance = this;
			new QuadRender(null);
			new ImageRender(null);
			_stage.addChild(new _rootClass as DisplayObject);
		}
		
		public function requestContext2D():void
		{
			_stage3D.addEventListener(Event.CONTEXT3D_CREATE,onContext3DCreated);
			_stage3D.requestContext3D(Context3DRenderMode.AUTO);
		}
		
		private function onContext3DCreated(e:Event):void
		{
			_context = new Context2D(_stage3D.context3D);
			_stage3D.context3D.configureBackBuffer(_nativeStage.stageWidth,_nativeStage.stageHeight,2,false);
			init();
			dispatchEvent(new Event("contextCreated"));
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(_started && _context)
				nextFrame();
		}
		
		public static function get context():Context2D
		{
			return instance._context;
		}
		
		public static function get animationMaster():AnimationMaster
		{
			return instance._animaMaster;
		}
		
		public function nextFrame():void
		{
			_animaMaster.addvanceTime(0);
			render();
			_renderMaster.nextFrame();
		}
		
		public function render():void
		{
			_context.clear();
			_stage.render(_renderMaster);
			_renderMaster.finishRender(null,null);
			_context.present();
		}

		public static function get instance():Alcedo
		{
			return _instance;
		}

		public function start():void
		{
			_started = true;
		}
		
		public function stop():void
		{
			_started = false;
		}
	}
}
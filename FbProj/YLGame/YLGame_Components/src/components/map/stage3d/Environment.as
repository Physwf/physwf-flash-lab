package components.map.stage3d
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;

	public class Environment
	{
		public static var stage3D:Stage3D;
		public static var context3D:Context3D;
		public static var program:Program3D;
		
		private static var pieces:Vector.<Piece>;
		
		public function Environment()
		{
		}
		
		public static function initialize(stage:Stage,onComplete:Function=null):void
		{
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,function (e:Event):void 
			{
				onContext3DCreated(stage);
				onComplete();
			});
			stage3D.requestContext3D();
		}
		
		private static function onContext3DCreated(stage:Stage):void
		{
			context3D = stage3D.context3D;
			context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,2,true);
			context3D.enableErrorChecking = true;
			
			//perspective matrix
			var pm:Matrix3D = new Matrix3D(Vector.<Number>(
				[
					2/stage.stageWidth,0,0,0,
					0,-2/stage.stageHeight,0,0,
					0,0,0,0,
					-1,1,0,1
				]));
			var pm2:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			pm2.identity();
			pm2.perspectiveFieldOfViewLH(1,stage.stageWidth/stage.stageHeight,1,10000);
			
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm,true);
			
			//register program
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var vertexSrc:String = "m44 op,va0,vc0 \n" +
									"mov v0,va1";
			var fragmentSrc:String = "tex ft0,v0,fs0 <2d,nearest>\n" +
									"mov oc,ft0";
			
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
			
			program = context3D.createProgram();
			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			context3D.setProgram(program);
			
			pieces = new Vector.<Piece>();
		}
		
		public static function getProgram(name:String):Program3D
		{
			return null;// to do
		}
		
		public static function addPiece(piece:Piece):void
		{
			pieces.push(piece);
		}
		
		public static function render():void
		{
			context3D.clear(0,0,0,1);
			for(var i:uint=0;i<pieces.length;++i)
			{
				pieces[i].render();
			}
			context3D.present();
		}
	}
}
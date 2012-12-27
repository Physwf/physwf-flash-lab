package test
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	
	/**
	 * Incubator Example,
	 * James Li, http://jamesli.cn
	 * 
	 * This example will teach you how to use Molehill low-level API 
	 * to create a simple triangle with vertext and fragment shaders.
	 * */
	[SWF(framerate=120,backgroundColor=0x000000,width=800,height=600)]
	public class IncubatorExample extends Sprite
	{
		private var stage3D:Stage3D;
		private var w:Number;
		private var h:Number;
		private var context3D:Context3D;
		private var indexBuffer:IndexBuffer3D;
		
		private var perspection:PerspectiveMatrix3D;
		private var modelView:Matrix3D;
		
		private var ro:Number = 1;
		
		public function IncubatorExample()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		private function onAdded(pEvent:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			initStage3D();
		}
		private function initStage3D():void{
			//First, you need initialize your stage as you program any 2D projects.

			stage.align = StageAlign.BOTTOM_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			w = stage.stageWidth;
			h = stage.stageHeight;
			
			//You need to a create 3D stage.
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, contextReady);
			stage3D.requestContext3D(Context3DRenderMode.AUTO);
//			stage3D.viewPort = new Rectangle(0,0,w,h);
		}
		private function contextReady(pEvent:Event):void{
			//Initialize context3D;
			context3D = stage3D.context3D;
			context3D.configureBackBuffer(w,h,2,true);
			
			//Create vertex assembler;
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			vertexAssembler.assemble(Context3DProgramType.VERTEX,
				"m44 op,va0,vc0 \n"+
				"mov v0,va1");
			
			//Create fragment assembler;
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,
				"mov oc,v0");
			
			//Init vertex buffer.
//			var vertexBuffer:VertexBuffer3D = context3D.createVertexBuffer(3,6);
//			vertexBuffer.uploadFromVector(Vector.<Number>([
//				-1,-1,1,1,0,0,
//				0,2,1,0,1,0,
//				1,-1,1,0,0,1
//			]),0,3);
			//Init vertex buffer.
			var vertexBuffer:VertexBuffer3D = context3D.createVertexBuffer(4,6);
			vertexBuffer.uploadFromVector(Vector.<Number>([
				-1,-1,1,1,0,0,
				1,-1,1,0,1,0,
				1,1,1,0,0,1,
				-1,1,1,0,1,1
			]),0,4);
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_3);
			
//			indexBuffer = context3D.createIndexBuffer(6);
//			indexBuffer.uploadFromVector(Vector.<uint>([
//				0,1,2
//				]),0,3);
			indexBuffer = context3D.createIndexBuffer(6);
			indexBuffer.uploadFromVector(Vector.<uint>([
				0,1,2,2,3,0
				]),0,6);
			
			var program:Program3D = context3D.createProgram();
			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			context3D.setProgram(program);
			
			perspection = new PerspectiveMatrix3D();
			perspection.identity();
			perspection.perspectiveLH(5,5,1,10000);
			
			modelView = new Matrix3D();
			modelView.identity();

			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		private function enterFrameHandler(pEvent:Event):void{
			context3D.clear();
			
//			modelView.appendRotation(ro, Vector3D.Z_AXIS);
			
			var modelProjection:Matrix3D = new Matrix3D();
			modelProjection.identity();
//			modelProjection.append(modelView);
			modelProjection.append(perspection);
			
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,perspection,true);
			
			context3D.drawTriangles(indexBuffer);
			context3D.present();
		}
	}
}
package test
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;

	public class Plane2dTest extends Sprite
	{
		private var stage3D:Stage3D;
		private var context3D:Context3D;
		private var vertexBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		
		
		public function Plane2dTest()
		{
			stage?onAddToStage(null):
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE,onContext3DCreated);
			stage3D.requestContext3D();
		}
		
		private function onContext3DCreated(e:Event):void
		{
			context3D = stage3D.context3D;
			context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,2,true);
			vertexBuffer = context3D.createVertexBuffer(4,6);
			indexBuffer = context3D.createIndexBuffer(6);
			
			var vertexData:Vector.<Number>;
			var indexData:Vector.<uint>;
			
			vertexBuffer.uploadFromVector(Vector.<Number>([
				-1,-1,2,1,0,0,
				1,-1,2,0,1,0,
				1,1,2,0,0,1,
				-1,1,2,0,1,1
			]),0,4);
			indexBuffer.uploadFromVector(Vector.<uint>([
				0,1,2,2,3,0
			]),0,6);
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_3);
			
			modelView.identity();
//			modelView.appendTranslation(0,0,-10);
//			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,modelView,true);
			
			
			
			
			
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var vertexSrc:String = "m44 op,va0,vc0 \n" +
//				"m44 op,vt0,vc4 \n" +
				"mov v0,va1";
			var fragmentSrc:String = "mov oc,v0";
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
			
//			context3D.setCulling(Context3DTriangleFace.FRONT);
			
			var program:Program3D = context3D.createProgram();
			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			
			context3D.setProgram(program);
			
			
//			context3D.drawTriangles(indexBuffer,0,2);
//			context3D.present();
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private var modelView:Matrix3D = new Matrix3D();
		
		private function onEnterFrame(e:Event):void
		{
			context3D.clear(0,0,0,1);
			
			var pm:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			pm.identity();
//			pm.perspectiveLH(5,5,1,10000);
			pm.perspectiveFieldOfViewLH(1,stage.stageWidth/stage.stageHeight,1,10000);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm,true);
			
			context3D.drawTriangles(indexBuffer);
			
			context3D.present();
		}
	}
}
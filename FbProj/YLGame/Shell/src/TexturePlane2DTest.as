package
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	
	[SWF(width="1000",height="600",frameRate="60", backgroundColor="#0")]
	public class TexturePlane2DTest extends Sprite
	{
		private var stage3D:Stage3D;
		private var context3D:Context3D;
		private var vertexBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		
//		[Embed(source="../texture/flower.png")]
		private var Flower:Class;
		
		public function TexturePlane2DTest()
		{
			super();
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
			vertexBuffer = context3D.createVertexBuffer(4,5);
			indexBuffer = context3D.createIndexBuffer(6);
			
			var vertexData:Vector.<Number>;
			var indexData:Vector.<uint> ;
			/**	1 -	2
			 * 	| /	|
			 * 	0 - 3
			 **/
			var offsetX:uint = 400;
			var offsetY:uint = 500;
			vertexBuffer.uploadFromVector(Vector.<Number>([
				-offsetX,256-offsetY,0, 0,1, 
				-offsetX,0-offsetY, 0,  0,0,
				256-offsetX,0-offsetY, 0,   1,0, 
				256-offsetX,256-offsetY,0,  1,1
			]),0,4);
			indexBuffer.uploadFromVector(Vector.<uint>([
				0,1,2,2,3,0
			]),0,6);
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
			
			var flower:BitmapData = new BitmapData(256,256,true,0xFFFF0000);
			var texture:Texture = context3D.createTexture(flower.width,flower.height,Context3DTextureFormat.BGRA,true);
			texture.uploadFromBitmapData(flower,0);
			context3D.setTextureAt(0,texture);
			
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var vertexSrc:String = "m44 op,va0,vc0 \n" 
				+ "mov v0,va1 \n" 
			
			var fragmentSrc:String = "tex ft0,v0,fs0 <2d,nearest> \n" 
				+ "mov oc,ft0";
			
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
			
			var program:Program3D = context3D.createProgram();
			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			context3D.setProgram(program);
			
			var pm1:Matrix3D = new Matrix3D(Vector.<Number>(
				[
					2/stage.stageWidth,0,0,0,
					0,-2/stage.stageHeight,0,0,
					0,0,0,0,
					1,-1,0,1
				]));
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm1,true);
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		private var modelView:Matrix3D = new Matrix3D();
		
		private function onEnterFrame(e:Event):void
		{
			context3D.clear(0,0,0,1);
			context3D.drawTriangles(indexBuffer);
			context3D.present();
		}
	}
}
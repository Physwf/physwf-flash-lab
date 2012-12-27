package test
{
	import com.adobe.utils.AGALMiniAssembler;
	import com.adobe.utils.PerspectiveMatrix3D;
	
	import flash.display.Bitmap;
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
	
	public class DynamicTextureTest extends Sprite
	{
		private var stage3D:Stage3D;
		private var context3D:Context3D;
		private var vertexBuffer:VertexBuffer3D;
		private var indexBuffer:IndexBuffer3D;
		
		private var texVertexBuffer:VertexBuffer3D;
		private var texIndexBuffer:IndexBuffer3D;
		
		private var texture:Texture;
		private var target:Texture;
		private var program:Program3D;
		
		[Embed(source="../texture/flower.png")]
		private var Flower:Class;
		[Embed(source="../texture/bird.jpg")]
		private var Bird:Class;
		
		public function DynamicTextureTest()
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
			
			
			vertexBuffer = context3D.createVertexBuffer(4,9);
			indexBuffer = context3D.createIndexBuffer(6);
			
			texVertexBuffer = context3D.createVertexBuffer(4,9);
			texIndexBuffer = context3D.createIndexBuffer(6);
			
			var flower:Bitmap = new Flower() as Bitmap;
			texture = context3D.createTexture(flower.width,flower.height,Context3DTextureFormat.BGRA,true);
			texture.uploadFromBitmapData(flower.bitmapData,0);
			
			
			var bird:Bitmap = new Bird() as Bitmap;
			target = context3D.createTexture(bird.width,bird.height,Context3DTextureFormat.BGRA,true);
			target.uploadFromBitmapData(bird.bitmapData,0);
			
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			
			var vertexSrc:String = "m44 op,va0,vc0 \n" +
				"mov v0,va1\n" +
				"mov v1,va2";
			
			var fragmentSrc:String = "tex ft0,v0,fs0 <2d,nearest> \n" +
				"mul ft1,ft0,v1.w\n"+
				"mov oc,ft1";
			
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
			
			program = context3D.createProgram();
			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			context3D.setProgram(program);
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		private var modelView:Matrix3D = new Matrix3D();
		
		private function renderDisplay():void
		{
			var vertexData:Vector.<Number>;
			var indexData:Vector.<uint> ;
			/**	1 -	2
			 * 	| /	|
			 * 	0 - 3
			 **/
			vertexBuffer.uploadFromVector(Vector.<Number>([
				0,		0,		5, 	0,	0, 	.1,.1,	1,	1,
				256,	0, 		5,  1,	0, 	.5,.1,	1,	1,
				256,	256,	5,  1,	1, 	1,	1,	1,	1,
				0,		256,	5,  0,	1, 	1,	1,	1,	1
			]),0,4);
			indexBuffer.uploadFromVector(Vector.<uint>([
				0,1,2,2,3,0
			]),0,6);
			
			context3D.setVertexBufferAt(0,vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,vertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
			context3D.setVertexBufferAt(2,vertexBuffer,5,Context3DVertexBufferFormat.FLOAT_4);
			context3D.setTextureAt(0,texture);
			
			var pm:Matrix3D = new Matrix3D(Vector.<Number>(
				[
					2/stage.stageWidth, 0,  0, 0,
					0, -2/stage.stageHeight, 0, 0,
					0,  0,    0, 0,
					-1, 1,    0, 1
				]));
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm,true);
			context3D.setRenderToBackBuffer();
			context3D.clear(0,0,0,1);
			context3D.drawTriangles(indexBuffer);
			context3D.present();
			
			context3D.setTextureAt(0,null);
			context3D.setVertexBufferAt(0,null);
			context3D.setVertexBufferAt(1,null);
			context3D.setVertexBufferAt(2,null);
		}
		
		private function renderTexture():void
		{

			
			var vertexData:Vector.<Number>;
			var indexData:Vector.<uint> ;
			/**	1 -	2
			 * 	| /	|
			 * 	0 - 3
			 **/
			texVertexBuffer.uploadFromVector(Vector.<Number>([
				0,		0,		5, 	0,	0, 	.1,.1,	1,	1,
				256,	0, 		5,  1,	0, 	.5,.1,	1,	1,
				256,	256,	5,  1,	1, 	1,	1,	1,	1,
				0,		256,	5,  0,	1, 	1,	1,	1,	1
			]),0,4);
			texIndexBuffer.uploadFromVector(Vector.<uint>([
				0,1,2,2,3,0
			]),0,6);
			
			context3D.setVertexBufferAt(0,texVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1,texVertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
			context3D.setVertexBufferAt(2,texVertexBuffer,5,Context3DVertexBufferFormat.FLOAT_4);
			
			
			context3D.setTextureAt(0,target);
			
//			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
//			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
//			
//			var vertexSrc:String = "m44 op,va0,vc0 \n" +
//				"mov v0,va1\n" +
//				"mov v1,va2";
//			
//			var fragmentSrc:String = "tex ft0,v0,fs0 <2d,nearest> \n" +
//				"mul ft1,ft0,v1.w\n"+
//				"mov oc,ft1";
//			
//			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexSrc);
//			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentSrc);
//			
//			var program:Program3D = context3D.createProgram();
//			program.upload(vertexAssembler.agalcode,fragmentAssembler.agalcode);
			context3D.setProgram(program);
			
			var pm:Matrix3D = new Matrix3D(Vector.<Number>(
				[
					2/512, 0,  0, 0,
					0, -2/512, 0, 0,
					0,  0,    0, 0,
					-1, 1,    0, 1
				]));
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,pm,true);
			context3D.setRenderToTexture(texture,true,0,0);
			context3D.clear(0,0,0,1);
			var flower:Bitmap = new Flower() as Bitmap;
			texture.uploadFromBitmapData(flower.bitmapData,0);
			context3D.drawTriangles(texIndexBuffer,0,2);
			
			
			context3D.setTextureAt(0,null);
			context3D.setVertexBufferAt(0,null);
			context3D.setVertexBufferAt(1,null);
			context3D.setVertexBufferAt(2,null);
		}
		
		private function onEnterFrame(e:Event):void
		{
			renderTexture();
			renderDisplay();
		}
	}
}
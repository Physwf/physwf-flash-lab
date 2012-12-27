package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.utils.getTimer;
	
	import psw2d.pass.Pass;
	import psw2d.pass.PassGrayscale;
	import psw2d.pass.PassSinWave;
	
	public class SinWaveTest extends Sprite
	{
		private var _waveLength:Number=100;
		private var _waveAmplifier:Number=0.1;
		private var _time:Number;
		
		[Embed(source="../texture/Alcedo.jpg")]
		private var AlcedoPic:Class;
		
		public function SinWaveTest()
		{
			!stage
			?addEventListener(Event.ADDED_TO_STAGE,init)
			:init(null);
		}
		
		private function init(e:Event):void
		{
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE,onContextCreated);
			stage.stage3Ds[0].requestContext3D();
		}
		
		private var _context3D:Context3D;
		private var _vertexBuffer:VertexBuffer3D;
		private var _indexBuffer:IndexBuffer3D;
		private var _waveParams:Vector.<Number>;
		private var _projMatrix:Matrix3D;
		private var _sinWavePass:PassSinWave;
		private var _grayPass:Pass;
		
		private var _zeroWave:Texture;
		private var _texture:Texture;
		
		private function onContextCreated(e:Event):void
		{
			_context3D = stage.stage3Ds[0].context3D;
			_context3D.enableErrorChecking = true;
			_context3D.configureBackBuffer(stage.stageWidth,stage.stageHeight,2,false);
			_vertexBuffer = _context3D.createVertexBuffer(4,4);
			_indexBuffer = _context3D.createIndexBuffer(6);
			var w:Number = 1;
			_vertexBuffer.uploadFromVector(Vector.<Number>(
				[
					0,	0,		0,0,
					512,0,		1,0,
					512,512,	1,1,
					0,	512,	0,1
				]),0,4);
			
			_indexBuffer.uploadFromVector(Vector.<uint>([0,1,2,2,3,0]),0,6);
			var sw:Number = stage.stageWidth;
			var sh:Number = stage.stageHeight;
			_projMatrix = new Matrix3D(Vector.<Number>(
				[
					2/sw, 0,  0, 0,
					0, -2/sh, 0, 0,
					0,  0,    0, 0,
					-1, 1,    0, 1
				]));
				
			_sinWavePass = new PassSinWave(_context3D,false,1,1);
			_sinWavePass.assemble();
			
//			_grayPass = new PassGrayscale(_context3D,true,512,512);
			_grayPass = new PassGrayscale(_context3D,false,512,512);
			_grayPass.assemble();
			
			_waveParams = new <Number>[_waveLength,_waveAmplifier,_time,0.5];
			
			var alcedo:Bitmap = new AlcedoPic() as Bitmap;
			_texture = _context3D.createTexture(alcedo.width,alcedo.height,Context3DTextureFormat.BGRA,false);
			_texture.uploadFromBitmapData(alcedo.bitmapData,0);
			
			_zeroWave = _context3D.createTexture(alcedo.width,alcedo.height,Context3DTextureFormat.BGRA,false);
			_zeroWave.uploadFromBitmapData(new BitmapData(alcedo.width,alcedo.height,true,0),0);
			
			_context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX,0,_projMatrix,true);
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, Vector.<Number>([.299, .587, .114, 3]) );
			
			_context3D.setVertexBufferAt(0,_vertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
			_context3D.setVertexBufferAt(1,_vertexBuffer,2,Context3DVertexBufferFormat.FLOAT_2);
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			_time = getTimer();
			_waveParams[2] = _time/100;
			_context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,_waveParams);
			_context3D.setTextureAt(0,_texture);
			_context3D.setTextureAt(1,null);
			
			_grayPass.render(_indexBuffer);
			
//			_context3D.setTextureAt(0,_grayPass.getTexture());
//			_context3D.setTextureAt(1,_zeroWave);
//			_sinWavePass.render(_indexBuffer);
			
			_context3D.present();
		}
	}
}
package components.map.gpu
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.display3D.textures.Texture;

	public class Piece
	{
		private var mX:int;
		private var mY:int;
		private var mWidth:uint;
		private var mHeight:uint;
		
		private var mVertexBuffer:VertexBuffer3D;
		private var mIndexBuffer:IndexBuffer3D;
		private var mTexture:Texture;
		
		public function Piece(x:int,y:int,w:uint,h:uint)
		{
			mX = x;	mY = y;	mWidth = w; mHeight = h;
			init();
		}
		
		private function init():void
		{
			var context3D:Context3D = Environment.context3D;
			mVertexBuffer = context3D.createVertexBuffer(4,5);
			mIndexBuffer = context3D.createIndexBuffer(6);
			
			var vertexData:Vector.<Number> = Vector.<Number>
				(
					[
						mX,			mY,			0,0,0,
						mX+mWidth,	mY,			0,1,0,
						mX+mWidth,	mY+mHeight,	0,1,1,
						mX,			mY+mHeight,	0,0,1
					]
				);
			
			var indexData:Vector.<uint> = Vector.<uint>([3,0,1,1,2,3]);
			
			mVertexBuffer.uploadFromVector(vertexData,0,4);
			mIndexBuffer.uploadFromVector(indexData,0,6);
			
			context3D.setVertexBufferAt(0,mVertexBuffer,0,Context3DVertexBufferFormat.FLOAT_2);
			context3D.setVertexBufferAt(1,mVertexBuffer,3,Context3DVertexBufferFormat.FLOAT_2);
			
			mTexture = context3D.createTexture(mWidth,mHeight,Context3DTextureFormat.BGRA,false);
			var c:uint = 0xFFFFFFFF * Math.random();
			mTexture.uploadFromBitmapData(new BitmapData(mWidth,mHeight,true,c),0);
//			context3D.setTextureAt(0,mTexture);
		}
		
		public function uploadTexture(source:BitmapData):void
		{
			mTexture.uploadFromBitmapData(source);
		}
		
		public function render():void
		{
			var context3D:Context3D = Environment.context3D;
			context3D.setTextureAt(0,mTexture);
//			context3D.setProgram(Environment.program);
			context3D.drawTriangles(mIndexBuffer);
		}
	}
}
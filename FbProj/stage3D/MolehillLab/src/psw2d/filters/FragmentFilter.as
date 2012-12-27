package psw2d.filters
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display3D.Context3DProgramType;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import psw2d.Alcedo;
	import psw2d.core.Context2D;
	import psw2d.display.DisplayObject;
	import psw2d.render.RenderMaster;
	import psw2d.texture.Texture;
	import psw2d.utlis.QuadVertex;

	public class FragmentFilter
	{
		protected var _texture:Texture;
		protected var _target:Texture;
		public function set target(target:Texture):void { _target = target; }
		
		protected var _vertexData:QuadVertex;
		protected var _vertexBuffer:VertexBuffer3D;
		protected var _indexData:Vector.<uint>;
		protected var _indexBuffer:IndexBuffer3D;
		
		protected var _bound:Rectangle;
		
		public function FragmentFilter(texture:Texture)
		{
			_texture = texture;
			
			_vertexData = new QuadVertex();
			_vertexData.setTexCoords(0,0,0);
			_vertexData.setTexCoords(1,1,0);
			_vertexData.setTexCoords(2,1,1);
			_vertexData.setTexCoords(3,0,1);
			_vertexData.setColor(0,0xFFFF000000);
			_vertexData.setColor(1,0xFFFF000000);
			_vertexData.setColor(2,0xFFFF000000);
			_vertexData.setColor(3,0xFFFF000000);
			
			_indexData = new <uint>[0,1,2,2,3,0];
			
			_bound = new Rectangle(0,0,256,256);
			
			createPrograms();
//			Sparrow.instance.addEventListener("contextCreated",onContextCreated);
		}
		
		private function onContextCreated(e:Event):void
		{
			_vertexBuffer = null;
			_indexBuffer = null;
			createPrograms();
		}
		
		public function render(object:DisplayObject,renderMaster:RenderMaster,parentAlpha:Number):void
		{
			var context:Context2D = Alcedo.context;
			updateBuffers(context);
			renderTexture(context);
			object.render(renderMaster,parentAlpha);
		}
		
		private function updateBuffers(context:Context2D):void
		{
			_vertexData.setPosition(0,_bound.x,_bound.y);
			_vertexData.setPosition(1,_bound.right,_bound.y);
			_vertexData.setPosition(2,_bound.right,_bound.bottom);
			_vertexData.setPosition(3,_bound.x,_bound.bottom);
			
			if(_vertexBuffer == null)
			{
				_vertexBuffer = context.createVertexBuffer(1);
				_indexBuffer = context.createIndexBuffer(1);
				_indexBuffer.uploadFromVector(_indexData,0,6);
			}
			_vertexBuffer.uploadFromVector(_vertexData.rawData,0,4);
			
		}
		
		private function renderTexture(context:Context2D):void
		{
			context.setPosForVertex(_vertexBuffer);
			context.setColorForVertex(_vertexBuffer);
			context.setVertexAndTextureForImage(_texture.base,_vertexBuffer);
			context.setOrthographicProjection(_target.width,_target.height);
			context.setProgram(FOO_PROGRAM);
			context.clear(0,0,0,1);
			context.renderTarget = _target;
			context.drawTriangles(_indexBuffer,0,2);
			context.clearBufferForImage();
			context.renderTarget = null;
		}
		
		private const FOO_PROGRAM:String = "foo_p";
		protected function createPrograms():void
		{
			var vertexCode:String = "m44 op,va0,vc0 \n" +
				"mov v0,va1 \n"+
				"mov v1,va2";
			var fragmentCode:String = "tex ft0,v1,fs0 <2d,linear,nearest>\n" +
				"mul ft1,v1,ft0 \n" +
				"mov oc,ft1";
			var vertexAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			var fragmentAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			
			vertexAssembler.assemble(Context3DProgramType.VERTEX,vertexCode);
			fragmentAssembler.assemble(Context3DProgramType.FRAGMENT,fragmentCode);
			
			Alcedo.context.registerProgram(FOO_PROGRAM,vertexAssembler.agalcode,fragmentAssembler.agalcode);
		}
	}
}
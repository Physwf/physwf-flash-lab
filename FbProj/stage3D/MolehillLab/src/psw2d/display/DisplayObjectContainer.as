package psw2d.display
{
	import psw2d.Alcedo;
	import psw2d.display.animation.IAnimation;
	import psw2d.render.RenderMaster;

	public class DisplayObjectContainer extends DisplayObject
	{
		private var _children:Vector.<DisplayObject>;
		private var _numChildren:int;
		
		public function DisplayObjectContainer()
		{
			super();
			_children = new <DisplayObject>[];
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			_children.push(child);
			if(child is IAnimation) Alcedo.animationMaster.add(child as IAnimation);
			_numChildren ++;
			return child
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			var index:int = _children.indexOf(child);
			if(index>-1) return _children.splice(index,1)[0] as DisplayObject;
			return null;
		}
		
		override public function render(renderMaster:RenderMaster,parentAlpha:Number=1.0):void
		{
			var alpha:Number = parentAlpha * this.alpha;
			var child:DisplayObject;
			
			for(var i:int=0;i<_numChildren;++i)
			{
				child = _children[i];
				if(child.hasVisibleArea)
				{
					var blendMode:String = child.blendMode;
					var blendModeChange:Boolean = blendMode != BlendMode.AUTO;
					if(blendModeChange)
					{
						renderMaster.pushBlendMode();
						renderMaster.blendMode = blendMode;
					}
					renderMaster.pushMatrix();
					renderMaster.transformMatrix(child);
					
					if(child.filter) child.filter.render(child,renderMaster,parentAlpha);
					else child.render(renderMaster,alpha);
						
					renderMaster.popMatrix();
					if(blendModeChange)
					{
						renderMaster.popBlendMode();
					}
				}
			}
		}
	}
}
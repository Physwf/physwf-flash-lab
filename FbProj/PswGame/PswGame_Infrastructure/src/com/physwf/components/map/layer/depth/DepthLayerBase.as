package com.physwf.components.map.layer.depth
{
	import com.physwf.components.interfaces.IView;
	import com.physwf.components.map.camera.IScreen;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class DepthLayerBase implements IDepthLayer
	{
		private var _layerDisplay:Sprite;
		
		public function DepthLayerBase(screen:IScreen)
		{
			
		}
		
		public function addView(view:IView):IView
		{
			_layerDisplay.addChild(view.form);
			return view;
		}
		
		public function removeView(view:IView):IView
		{
			_layerDisplay.removeChild(view.form);
			return view;
		}
		
		public function updateElementDepth(view:IView):void
		{
		}
		
		public function updateAllElementsDepth():void
		{
		}
		
		public function get x():Number
		{
			return 0;
		}
		
		public function get y():Number
		{
			return 0;
		}
		
		public function set x(v:Number):void
		{
		}
		
		public function set y(v:Number):void
		{
		}
		
		public function set form(v:DisplayObject):void
		{
			_layerDisplay = v as Sprite;
		}
		
		public function get form():DisplayObject
		{
			return _layerDisplay;
		}
		
		public function render():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function destroy():void
		{
		}
	}
}
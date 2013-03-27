package shinater.swing.managers{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.FocusEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import shinater.transitions.Tween;
	import shinater.transitions.TweenEvent;
	import shinater.swing.Component;
	import shinater.swing.Button;
	import shinater.swing.ToggleButton;
	import shinater.swing.CheckBox;
	import shinater.swing.RadioButton;
	import shinater.swing.MenuItem;
	import shinater.swing.CheckBoxMenuItem;
	import shinater.swing.RadioButtonMenuItem;
	import shinater.swing.MenuBar;
	import shinater.swing.TextInput;
	import shinater.swing.TextArea;
	import shinater.swing.ComboBox;
	import shinater.swing.NumericStepper;
	import shinater.swing.List;
	import shinater.swing.ListCellRenderer;
	import shinater.swing.Tree;
	import shinater.swing.TreeCellRenderer;
	import shinater.swing.ScrollBar;
	import shinater.swing.ProgressBar;
	import shinater.swing.Accordion;
	import shinater.swing.BorderLayoutPanel;
	import shinater.swing.ToolBar;

	
	public class TransitionStyleManager {
		use namespace swing_style;
		
		public static function setEnabled(enabled:Boolean):void {
			if(!enabled){
				return;
			}
			initComponentPrototype();
			StyleManager.setEnabled(enabled);
		}
		private static function initComponentPrototype():void {
									PopUpManager.prototype.show = function(popup:Component,_1:Component,_2:Number,_3:Number){
								var _4:Point = new Point(_2,_3);
				_4 = _1.localToGlobal(_4);
				var _5:DisplayObjectContainer = DisplayObjectContainer(_1.root);
				if (this.modalWindow == null) {
					this.createModalWindow(_5);
				}
				var _6:DisplayObject = this.modalWindow;
				_5.addChild(_6);
				_6.visible = true;
				this.mouseReleased = false;
				this.focusManagerEnabled = FocusManager.getEnabled();
				FocusManager.setEnabled(false);
				_5.addChild(popup);
				popup.visible = true;
				popup.dispatchEvent(new Event("show"));
				this.popupComponent = popup;
				this.popupInvoker = _1;
				FocusManager.setFocus(popup);
				var _7:Number = popup.width;
				var _8:Number = popup.height;
				var _9:Stage = _1.stage;
				var _10:Number = _9.stageWidth;
				var _11:Number = _9.stageHeight;
				if ((popup is List) && (_1 is ComboBox)) {
					if (_4.y + _8 > _11) {
						_4 = _1.localToGlobal(new Point(_2,0));
						_4 = popup.parent.globalToLocal(_4);
						popup.setLocation(_4.x,_4.y);
						popup.scrollRect = new Rectangle(0,0,_7,0);
						new Tween(popup,"y",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
							return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
						},popup.y,popup.y - _8,0.25,true,80).addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
					  		var _15:Tween = Tween(evt.currentTarget);
					  		var _16:DisplayObject = DisplayObject(_15.obj);
					  		var _17:Rectangle = _16.scrollRect;
					  		_17.height = _15.begin - evt.position;
					  		_16.scrollRect = _17;
							evt.updateAfterEvent();
						});
					} else {
						_4 = popup.parent.globalToLocal(_4);
						popup.setLocation(_4.x,_4.y);
						var _17:Rectangle = new Rectangle(0,_8,_7,_8);
						popup.scrollRect = _17;
						new Tween(popup,"",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
							return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
						},_8,0,0.25,true,80).addEventListener(TweenEvent.MOTION_CHANGE,function(evt:TweenEvent){
						    var _15:Tween = Tween(evt.currentTarget);
					 	    var _16:DisplayObject = DisplayObject(_15.obj);
					  		var _17:Rectangle = _16.scrollRect;
					  		_17.y = evt.position;
					  		_16.scrollRect = _17;
							evt.updateAfterEvent();
						});
					}
					return;
				}
				if (_4.x + _7 > _10) {
					_4.x -=  _7;
				}
				if (_4.y + _8 > _11) {
					_4.y = Math.max(_4.y - _8,0);
				}
				_4 = popup.parent.globalToLocal(_4);
				popup.setLocation(_4.x,_4.y);
			}
			PopUpManager.prototype.hide = function(popup:Component):void {
				popup.visible = false;
				if(popup == this.popupComponent){
					this.modalWindow.visible = false;
					popup.dispatchEvent(new Event("hide"));
					FocusManager.setFocus(this.popupInvoker);
					if(this.focusManagerEnabled){
						FocusManager.setEnabled(true);
					}
					this.popupComponent = null;
				}
			}
			MovieClip.prototype._fadeFrameRate = 8;
			MovieClip.prototype._fadeInterval = 1/8;
			MovieClip.prototype._fadeIn_onEnterFrame = function(evt:Event):void{
				var _25:MovieClip = MovieClip(evt.currentTarget);
				if(_25.alpha >= 1){
					_25.removeEventListener(Event.ENTER_FRAME,_25._fadeIn_onEnterFrame);
					return;
				}
				_25.alpha += _25._fadeInterval;
			}
			MovieClip.prototype._fadeOut_onEnterFrame = function(evt:Event):void{
				var _25:MovieClip = MovieClip(evt.currentTarget);
				if(_25.alpha <= 0){
					_25.removeEventListener(Event.ENTER_FRAME,_25._fadeOut_onEnterFrame);
					return;
				}
				_25.alpha -= _25._fadeInterval;
			}
			MovieClip.prototype._fadeIn = function(immediate:Boolean = false,_27:Number = 0):void{
				if(this.stage == null){
					immediate = true;
				}
				if(this.hasEventListener(Event.ENTER_FRAME)){
					this.removeEventListener(Event.ENTER_FRAME,this._fadeIn_onEnterFrame);
					this.removeEventListener(Event.ENTER_FRAME,this._fadeOut_onEnterFrame);
				}
				if(immediate){
					this.alpha = 1;
					return;
				}
				if(this.alpha < _27){
					this.alpha = _27;
					this._fadeInterval = (1-_27)/this._fadeFrameRate;
				}
				this.addEventListener(Event.ENTER_FRAME,this._fadeIn_onEnterFrame,false,0,true);
			}
			MovieClip.prototype._fadeOut = function(immediate:Boolean = false,_27:Number = 1):void{
				if(this.stage == null){
					immediate = true;
				}
				if(this.hasEventListener(Event.ENTER_FRAME)){
					this.removeEventListener(Event.ENTER_FRAME,this._fadeIn_onEnterFrame);
					this.removeEventListener(Event.ENTER_FRAME,this._fadeOut_onEnterFrame);
				}
				if(immediate){
					this.alpha = 0;
					return;
				}
				if(this.alpha > _27){
					this.alpha = _27;
					this._fadeInterval = _27/this._fadeFrameRate;
				}
				this.addEventListener(Event.ENTER_FRAME,this._fadeOut_onEnterFrame,false,0,true);
			}
			Component.prototype.animateSkin = null;
			Button.prototype._emphasizedSkin_onEnterFrame = function(evt:Event):void{
				var _25:MovieClip = MovieClip(evt.currentTarget);
				_25.alpha = Math.max(0, Math.min(1, _25.alpha+_25._fadeInterval));
				if(_25.alpha == 1 || _25.alpha == 0){
					_25._fadeInterval = -_25._fadeInterval;
				}
			}
			Button.prototype.setMouseState = function(state:String):void{
								var _30:uint = this.currentFrame;
				switch(state){
					case "up":
						this.gotoAndStop(1);
						break;
					case "over":
						this.gotoAndStop(2);
						break;
					case "down":
						this.gotoAndStop(3);
						break;
					case "disabled":
						this.gotoAndStop(4);
				}
				var _31:DisplayObject = !this.getEnabled() ? this.getDisabledIcon() : null;
				if(_31 == null){
					_31 = this.getIcon();
				}
				if(this.icon != _31){
					if (this.icon != null) {
						this.removeChild(this.icon);
					}
					if (_31 != null) {
						this.addChild(_31);
					}
					this.icon = _31;
				}
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(state == "up"){
					if(_32 != null){
						_32._fadeOut(_30 != 2);
					}
				}else{
					if(state == "over"){
						if(_32 != null){
							_32._fadeIn(_30 != 1);
						}
					}
					var _33:MovieClip = this.emphasizedSkin;
					if(_33 != null && _33.visible && _33.alpha != 0){
						_33.alpha = 0;
					}
				}
			}
			Button.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				this.repaint();
				var _34:MovieClip = this.skin;
				var _32:MovieClip = this.animateSkin;
				if(_32 != null && _34 != null){
					_32.width = _34.width;
					_32.height = _34.height;
				}
				var _33:MovieClip = this.emphasizedSkin;
				if(_33 != null){
					var _37:MovieClip = this.emphasizedAnimateSkin;
					if(_37 != null){
						_37.width = _33.width;
						_37.height = _33.height;
						if(_33.visible){
							_37.visible = true;
							if(!_37.hasEventListener(Event.ENTER_FRAME)){
								_37._fadeInterval = 1/24;
								_37.addEventListener(Event.ENTER_FRAME,this._emphasizedSkin_onEnterFrame,false,0,true);
							}
						}else if(_37.hasEventListener(Event.ENTER_FRAME)){
							_37.removeEventListener(Event.ENTER_FRAME,this._emphasizedSkin_onEnterFrame);
							_37.visible = false;
						}
					}
				}
				StyleManager.setEnabled(true);
			}
			ToggleButton.prototype.setMouseState = function(state:String):void{
								var _30:uint = this.currentFrame;
				var _39:Boolean = this.getSelected();
				switch(state){
					case "up":
						this.gotoAndStop(_39 ? 5:1);
						break;
					case "over":
						this.gotoAndStop(_39 ? 6:2);
						break;
					case "down":
						this.gotoAndStop(_39 ? 7:3);
						break;
					case "disabled":
						this.gotoAndStop(_39 ? 8:4);
				}
				var _31:DisplayObject = !this.getEnabled() ? this.getDisabledIcon() : null;
				if(_31 == null){
					_31 = this.getIcon();
				}
				if(this.icon != _31){
					if (this.icon != null) {
						this.removeChild(this.icon);
					}
					if (_31 != null) {
						this.addChild(_31);
					}
					this.icon = _31;
				}
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(_32 != null){
					if(state == "up"){
						_32._fadeOut(_30 != 2 && _30 != 6);
					}else if(state == "over"){
						_32._fadeIn(_30 != 1 && _30 != 5);
					}
				}
			}
			CheckBox.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(_32 != null){
					var _31:DisplayObject = this.icon;
					_32.x = _31.x;
					_32.y = _31.y;
				}
				StyleManager.setEnabled(true);
			}
			RadioButton.prototype.repaint = CheckBox.prototype.repaint;
			MenuItem.prototype.setMouseState = function(state:String):void{
								var _30:uint = this.currentFrame;
				var _45:Boolean = this.getEnabled();
				var _46:Boolean = this.arrowSkin != null && this.arrowSkin.visible;
				switch(state){
					case "up":
						this.gotoAndStop(_45 ? 1:4);
						break;
					case "over":
						this.gotoAndStop(_45 ? 2:5);
						break;
					case "down":
						if(!_45){
							return;
						}
						this.gotoAndStop(3);
				}
				var _31:DisplayObject = !_45 ? this.getDisabledIcon() : null;
				if(_31 == null){
					_31 = this.getIcon();
				}
				if(this.icon != _31){
					if (this.icon != null) {
						this.removeChild(this.icon);
					}
					if (_31 != null) {
						this.addChild(_31);
					}
					this.icon = _31;
				}
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(_32 != null){
					_32._fadeFrameRate = 5;
					if(state == "up"){
						_32._fadeOut(_30 == 2 && _30 == 5,0.5);
					}else if(state == "over"){
						_32._fadeIn(_30 == 1 && _30 == 4,0.5);
					}
				}
				if(this.arrowSkin != null){
					this.arrowSkin.visible = _46;
				}
			}
			CheckBoxMenuItem.prototype.setMouseState = function(state:String):void{
				var _30:uint = this.currentFrame;
				var _39:Boolean = this.getSelected();
				var _45:Boolean = this.getEnabled();
				switch(state){
					case "up":
						this.gotoAndStop(_39 ? (_45 ? 6 : 9): (_45 ? 1 : 4));
						break;
					case "over":
						this.gotoAndStop(_39 ? (_45 ? 7 : 10): (_45 ? 2 : 5));
						break;
					case "down":
						if(!_45){
							return;
						}
						this.gotoAndStop(_39 ? 8:3);
				}
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(_32 != null){
					_32._fadeFrameRate = 5;
					if(state == "up"){
						_32._fadeOut(_30 == 2 && _30 == 5 && _30 == 7 && _30 == 10,0.5);
					}else if(state == "over"){
						_32._fadeIn(_30 == 1 && _30 == 4 && _30 == 6 && _30 == 9,0.5);
					}
				}
			}
			RadioButtonMenuItem.prototype.setMouseState = CheckBoxMenuItem.prototype.setMouseState;
			MenuBar.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				var _32:MovieClip = this.labelButton.animateSkin;
				if(_32 != null && _32._fadeFrameRate == 8){
					_32.constructor.prototype._fadeFrameRate = 3;
				}
				this.repaint();
				StyleManager.setEnabled(true);
			}
			TextInput.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				if(!this.hasEventListener(MouseEvent.ROLL_OVER)){
					this.addEventListener(MouseEvent.ROLL_OVER,this._onRollOver,false,0,true);
					this.addEventListener(MouseEvent.ROLL_OUT,this._onRollOut,false,0,true);
				}
				this.repaint();
				var _34:MovieClip = this.skin;
				var _32:MovieClip = this.animateSkin;
				if(_32 != null && _34 != null){
					_32.width = _34.width;
					_32.height = _34.height;
				}
				StyleManager.setEnabled(true);
			}
			TextInput.prototype._onRollOver = function(evt:MouseEvent):void{
				var _32:MovieClip = evt.currentTarget.animateSkin;
				if(_32 != null){
					_32._fadeIn();
				}
			}
			TextInput.prototype._onRollOut = function(evt:MouseEvent):void{
				var _32:MovieClip = evt.currentTarget.animateSkin;
				if(_32 != null){
					_32._fadeOut();
				}
			}
			TextArea.prototype.repaint = TextInput.prototype.repaint;
			TextArea.prototype._onRollOver = TextInput.prototype._onRollOver;
			TextArea.prototype._onRollOut = TextInput.prototype._onRollOut;
			ComboBox.prototype._downArrow_onEnterFrame = function(evt:Event):void{
				var _58:Button = Button(evt.currentTarget);
				if(_58.currentFrame == 1 && _58.skin.alpha != 0){
					_58.skin.alpha = 0;
				}
			}
			ComboBox.prototype._downArrow_onRollOver = function(evt:MouseEvent):void{
				var _58:Button = Button(evt.currentTarget);
				var _60:ComboBox = ComboBox(_58.parent);
				var _61:TextInput = _60.textField;
				if(_61.hitTestPoint(evt.stageX,evt.stageY,true)){
					_61.dispatchEvent(evt);
				}
			}
			ComboBox.prototype._downArrow_onRollOut = function(evt:MouseEvent):void{
				var _58:Button = Button(evt.currentTarget);
				var _60:ComboBox = ComboBox(_58.parent);
				var _61:TextInput = _60.textField;
				if(!_61.hitTestPoint(evt.stageX,evt.stageY,true)){
					_61.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT,false,false,_61.mouseX,_61.mouseY));
				}
			}
			ComboBox.prototype._textField_onRollOut = function(evt:MouseEvent):void{
				var _61:TextInput = TextInput(evt.currentTarget);
				if(_61.hitTestPoint(evt.stageX,evt.stageY,true)){
					evt.stopImmediatePropagation();
				}
			}
			ComboBox.prototype._dropdown_onHide = function(evt:Event):void{
				var _66:List = List(evt.currentTarget);
				var _60:ComboBox = ComboBox(_66["__parent"]);
				var _61:TextInput = _60.textField;
				if(!_61.hitTestPoint(_61.stage.mouseX,_61.stage.mouseY,true)){
					_61.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT,false,false,_61.mouseX,_61.mouseY));
				}
			}
			ComboBox.prototype.repaint = function():void{
				
				var _69:Number = this.width;
				var _70:Number = this.height;
				var _61:TextInput = this.textField;
				var _58:Button = this.downArrow;
				var _66:List = this.dropdown;
				if(this.getEditable()){
					if(this.getChildIndex(_61) > this.getChildIndex(_58)){
						this.swapChildren(_61,_58);
					}
					if(!_61.skin.visible){
						_61.skin.visible = true;
					}
					_61.width = _69;
					_61.height = _70;
					_61.mouseEnabled = true;
					if(!_58.hasEventListener(Event.ENTER_FRAME)){
						_58.addEventListener(Event.ENTER_FRAME,this._downArrow_onEnterFrame,false,0,true);
						_58.addEventListener(MouseEvent.ROLL_OVER,this._downArrow_onRollOver,false,0,true);
						_58.addEventListener(MouseEvent.ROLL_OUT,this._downArrow_onRollOut,false,0,true);
						_61.addEventListener(MouseEvent.ROLL_OUT,this._textField_onRollOut,false,1,true);
						_66["__parent"] = this;
						_66.addEventListener("hide",this._dropdown_onHide,false,0,true);
					}
					var _3:Number = this["__downArrowY"] || _58.y;
					_70 -= _3 * 2;
					_58.setLabelPlacement("right");
					_58.setSize(_70,_70);
					_58.y = _3;
					_58.x = _69 - _58.y - _58.width;
					_61.repaint();
					_61.textField.width = _58.x - _61.textField.x;
										_66.width = _69;
				}else{
					if(this.getChildIndex(_61) < this.getChildIndex(_58)){
						this.swapChildren(_61,_58);
					}
					if(_61.skin.visible){
						_61.skin.visible = false;
					}
					_61.width = _69;
					_61.height = _70;
					_61.mouseEnabled = false;
					if(_58.hasEventListener(Event.ENTER_FRAME)){
						_58.removeEventListener(Event.ENTER_FRAME,this._downArrow_onEnterFrame);
						_58.removeEventListener(MouseEvent.ROLL_OVER, this._downArrow_onRollOver);
						_58.removeEventListener(MouseEvent.ROLL_OUT, this._downArrow_onRollOut);
						_58.skin.alpha = 1;
						_61.removeEventListener(MouseEvent.ROLL_OUT,this._textField_onRollOut);
						_66.removeEventListener("hide", this._dropdown_onHide);
					}
					if(_58.y != 0){
						this["__downArrowY"] = _58.y;
					}
					_58.x = 0;
					_58.y = 0;
					_58.setLabelPlacement("left");
					_58.setSize(_69,_70);
					_66.width = _69;
				}
											}
			NumericStepper.prototype._textField_onRollOut = function(evt:MouseEvent):void{
				var _61:TextInput = TextInput(evt.currentTarget);
				if(_61.hitTestPoint(evt.stageX,evt.stageY,true)){
					evt.stopImmediatePropagation();
				}
			}
			NumericStepper.prototype._onRollOut = function(evt:MouseEvent):void{
				var _61:TextInput = TextInput(evt.currentTarget.textField);
				_61.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT,false,false,_61.mouseX,_61.mouseY));
			}
			NumericStepper.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				this.repaint();
				StyleManager.setEnabled(true);
				var _61:TextInput = this.textField;
				_61.repaint();
				if(!this.hasEventListener(MouseEvent.ROLL_OUT)){
					_61.addEventListener(MouseEvent.ROLL_OUT,this._textField_onRollOut,false,1,true);
					this.addEventListener(MouseEvent.ROLL_OUT,this._onRollOut);
				}
			}
			ListCellRenderer.prototype.setMouseState = function(state:String):void{
								var _30:uint = this.currentFrame;
				var _39:Boolean = this.getSelected();
				switch(state){
					case "up":
						this.gotoAndStop(_39 ? 5:1);
						break;
					case "over":
						this.gotoAndStop(_39 ? 6:2);
						break;
					case "down":
						this.gotoAndStop(_39 ? 7:3);
						break;
					case "disabled":
						this.gotoAndStop(_39 ? 8:4);
				}
				var _31:DisplayObject = !this.getEnabled() ? this.getDisabledIcon() : null;
				if(_31 == null){
					_31 = this.getIcon();
				}
				if(this.icon != _31){
					if (this.icon != null) {
						this.removeChild(this.icon);
					}
					if (_31 != null) {
						this.addChild(_31);
					}
					this.icon = _31;
				}
				this.repaint();
				var _32:MovieClip = this.animateSkin;
				if(_32 != null){
					_32._fadeFrameRate = 5;
					if(state == "up"){
						_32._fadeOut(_30 != 2 && _30 != 6,0.3);
					}else if(state == "over"){
						_32._fadeIn(_30 != 1 && _30 != 5,0.4);
					}
				}
			}
			Tree.prototype.repaint = function():void{
								StyleManager.setEnabled(false);
				this.repaint();
				var _15:Tween = this["tween"];
				if(_15 != null && isNaN(_15.FPS)){
					_15.func = function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
						return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
					}
					_15.duration = 0.25;
					_15.FPS = 80;
				}
				StyleManager.setEnabled(true);
			}
			TreeCellRenderer.prototype.setMouseState = ListCellRenderer.prototype.setMouseState;
			TreeCellRenderer.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				this.repaint();
				var _34:MovieClip = this.skin;
				var _32:MovieClip = this.animateSkin;
				if(_32 != null && _34 != null){
					_32.x = _34.x;
					_32.y = _34.y;
					_32.width = _34.width;
					_32.height = _34.height;
				}
				StyleManager.setEnabled(true);
			}
			ScrollBar.prototype.repaint = function():void{
								if(!this.hasEventListener(MouseEvent.MOUSE_OVER) && this.upArrow.skin!=null){
					this.addEventListener(MouseEvent.MOUSE_OVER,this._onRollOver,false,0,true);
					this.addEventListener(MouseEvent.ROLL_OUT,this._onRollOut,false,0,true);
					this.addEventListener(MouseEvent.MOUSE_DOWN,this._onMouseDown,false,0,true);
					this.upArrow.skin["_fadeOut"](true);
					this.downArrow.skin["_fadeOut"](true);
				}
				StyleManager.setEnabled(false);
				this.repaint();
				StyleManager.setEnabled(true);
			}
			ScrollBar.prototype._onRollOver = function(evt:MouseEvent):void{
								var _88:ScrollBar = ScrollBar(evt.currentTarget);
				if(!_88.getEnabled()){
					return;
				}
				if(!_88.thumb.mouseEnabled){
					return;
				}
				var _89:Button = _88.upArrow;
				var _58:Button = _88.downArrow;
				if(_89.skin.alpha != 1){
					_89.skin["_fadeIn"](_89.animateSkin!=null && _89.animateSkin.alpha!=0);
					_58.skin["_fadeIn"](_58.animateSkin!=null && _58.animateSkin.alpha!=0);
				}
			}
			ScrollBar.prototype._onRollOut = function(evt:MouseEvent):void{
								var _88:ScrollBar = ScrollBar(evt.currentTarget);
				if(!_88.getEnabled()){
					return;
				}
				if(!_88.thumb.mouseEnabled){
					return;
				}
				_88.upArrow.skin["_fadeOut"]();
				_88.downArrow.skin["_fadeOut"]();
			}
			ScrollBar.prototype._onMouseDown = function(evt:MouseEvent):void{
				var _88:ScrollBar = ScrollBar(evt.currentTarget);
				ScrollBar.prototype._currentTarget = _88;
				_88.stage.addEventListener(MouseEvent.MOUSE_UP,_88._onMouseUp,false,0,true);
			}
			ScrollBar.prototype._onMouseUp = function(evt:MouseEvent):void{
				var _88:ScrollBar = ScrollBar.prototype._currentTarget;
				_88.stage.removeEventListener(MouseEvent.MOUSE_UP, _88._onMouseUp);
				if(!_88.hitTestPoint(evt.stageX,evt.stageY,true)){
					_88.upArrow.skin["_fadeOut"]();
					_88.downArrow.skin["_fadeOut"]();
				}
			}
			ProgressBar.prototype.repaint = function():void{
								var _7:Number = this.width;
				var _8:Number = this.height;
				var _96:Sprite = this.trackSkin;
				_96.width = _7;
				_96.height = _8;
				var _97:Sprite = this.barSkin;
				_7 -= _97.y * 2;
				_8 -= _97.y * 2;
				var _98:Sprite = this.maskSkin;
				if (_98 != null) {
					_98.width = _7;
					_98.height = _8;
				}
				_97.height = _8;
				var _15:Tween = this["__tween"];
				if(_15 != null && _15.isPlaying){
					_15.stop();
				}
				if(this.getIndeterminate()){
					
					if(!this.hasEventListener(Event.ENTER_FRAME)){
						this.addEventListener(Event.ENTER_FRAME,this._onEnterFrame,false,0,true);
					}
					return;
				}
				if(this.hasEventListener(Event.ENTER_FRAME)){
					this.removeEventListener(Event.ENTER_FRAME,this._onEnterFrame);
				}
				var _69:Number = _7 * (this.getValue() - this.getMinimum())/(this.getMaximum() - this.getMinimum());
				_69 = int(_69);
				if(_97.width >= _69){
					_97.width = _69;
					return;
				}
				if(_15 == null){
					this["__tween"] = _15 = new Tween(_97,"width", null,_97.width,_69,0.25,true,80);
					_15.addEventListener(TweenEvent.MOTION_CHANGE,this._onTweenUpdate,false,0,true);
				}else{
					_15.prop = "width";
					_15.begin = _97.width;
					_15.finish = _69;
					_15.looping = false;
					_15.start();
				}
			}
			ProgressBar.prototype._onTweenUpdate = function(evt:TweenEvent):void{
				var _97:Sprite = Sprite(evt.currentTarget.obj);
				var _102:ProgressBar = ProgressBar(_97.parent);
				var _7:Number = _102.width - _97.y * 2;
				var _17:Boolean = _102.getDirection() == "right";
				if(_102.getIndeterminate()){
					_97.width = int(_7 * 0.2);
					var _14:Number = int(_97.width*0.1);
					_97.x = _17 ? (_97.x >= _7 ? -_97.width : _97.x+_14) : (_97.x <= 0 ? _7 : _97.x-_14);
				}else{
					_97.x = _17 ? _97.y:_7 + _97.y - _97.width;
				}
				evt.updateAfterEvent();
			}
			ProgressBar.prototype._onEnterFrame = function(evt:Event):void{
				var _102:ProgressBar = ProgressBar(evt.currentTarget);
				var _97:Sprite = _102.barSkin;
				var _7:Number = _102.width - _97.y * 2;
				var _17:Boolean = _102.getDirection() == "right";
				if(_102.getIndeterminate()){
										
					_97.width = int(_7 * 0.2);
					var _14:Number = int(_97.width*0.1);
					_97.x = _17 ? (_97.x >= _7 ? -_97.width : _97.x+_14) : (_97.x <= 0 ? _7 : _97.x-_14);
				}else{
					var _69:Number = _7 * (_102.getValue() - _102.getMinimum())/(_102.getMaximum() - _102.getMinimum());
					_69 = int(_69);
					_14 = 2;
					if(_97.width + _14 < _69){
						_97.width += _14;
					}else{
						_97.width = _69;
						_102.removeEventListener(Event.ENTER_FRAME,_102._onEnterFrame);
					}
					_97.x = _17 ? _97.y:_7 + _97.y - _97.width;
				}
			}
			Accordion.prototype.repaint = function():void{
								StyleManager.setEnabled(false);
				this.repaint();
				var _15:Tween = this["tween"];
				if(_15 != null && isNaN(_15.FPS)){
					_15.func = function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
						return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
					}
					_15.duration = 0.25;
					_15.FPS = 80;
				}
				StyleManager.setEnabled(true);
			}
			BorderLayoutPanel.prototype.repaint = function():void{
				StyleManager.setEnabled(false);
				this.repaint();
				var _116:Sprite = this.topArea;
				var _117:Number = 0;
				if(_116 != null){
					_116.height = 0;
					_117 = _116.y;
				}
				var _118:Sprite = this.bottomArea;
				if(_118 != null){
					_118.height = 0;
					_118.y = this.skin.height - _117;
				}
				var _119:Sprite = this.leftArea;
				if(_119 != null){
					_119.width = 0;
					_117 = _119.x;
				}
				var _120:Sprite = this.rightArea;
				if(_120 != null){
					_120.width = 0;
					_120.x = this.skin.width - _117;
				}
				StyleManager.setEnabled(true);
			}
			ToolBar.prototype.repaint = function():void{
								StyleManager.setEnabled(false);
				this.repaint();
				if(this["__embarked"] == null){
					this.skin.addEventListener(MouseEvent.MOUSE_DOWN,this._onDragStart,false,0,true);
					this["__embarked"] = true;
				}
				StyleManager.setEnabled(true);
			}
			ToolBar.prototype._onDragStart = function(evt:Event):void{
								var _121:ToolBar = evt.currentTarget.parent.parent;
				if(!_121.getFloatable()){
					return;
				}
				if(!(_121.parent is BorderLayoutPanel)){
					return;
				}
				ToolBar.prototype._currentTarget = _121;
				_121.stage.addEventListener(MouseEvent.MOUSE_MOVE,_121._onDragOver,false,0,true);
				_121.stage.addEventListener(MouseEvent.MOUSE_UP,_121._onDragStop,false,0,true);
			}
			ToolBar.prototype._onDragOver = function(evt:MouseEvent){
								var _121:ToolBar = ToolBar.prototype._currentTarget;
				var _123:String = _121.getDirection();
				var _8:Number = _123 == "horizontal" ? _121.height : _121.width;
				var _125:BorderLayoutPanel = BorderLayoutPanel(_121.parent);
				var _12:Number,_14:Number;
				var _116:Sprite = _125.topArea;
				if(_116 != null){
					_12 = _116.height;
					_14 = _116.visible ? _8 : 0;
					_116.visible = true;
					if(_12 != _14){
						var _15:Tween = _125["__tweenTop"];
						if(_15 == null){
							_15 = _125["__tweenTop"] = new Tween(_116,"height",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
								return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
							},_12,_14,0.25,true,80);
						}else if(_15.finish != _14){
							_15.begin = _12;
							_15.finish = _14;
							_15.start();
						}
					}
				}
				var _118:Sprite = _125.bottomArea;
				if(_118 != null){
					_12 = _118.height;
					_14 = _118.visible ? _8 : 0;
					_118.visible = true;
					if(_12 != _14){
						_15 = _125["__tweenBottom"];
						if(_15 == null){
							_15 = _125["__tweenBottom"] = new Tween(_118,"height",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
								return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
							},_12,_14,0.25,true,80);
							_15.addEventListener(TweenEvent.MOTION_CHANGE,function(e:TweenEvent){
								var _25:Sprite = e.currentTarget.obj;
								var _138:BorderLayoutPanel = BorderLayoutPanel(_25.parent);
								var _15:Sprite = _138.topArea;
								var _16:Number = _15 != null ? _15.y : 0;
								_25.y = _138.skin.height - _16 - _25.height;
							});
						}else if(_15.finish != _14){
							_15.begin = _12;
							_15.finish = _14;
							_15.start();
						}
					}
				}
				var _7:Number = _123 == "vertical" ? _121.width : _121.height;
				var _119:Sprite = _125.leftArea;
				if(_119 != null){
					_12 = _119.width;
					_14 = _119.visible ? _7 : 0;
					_119.visible = true;
					if(_12 != _14){
						_15 = _125["__tweenLeft"];
						if(_15 == null){
							_15 = _125["__tweenLeft"] = new Tween(_119,"width",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
								return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
							},_12,_14,0.25,true,80);
						}else if(_15.finish != _14){
							_15.begin = _12;
							_15.finish = _14;
							_15.start();
						}
					}
				}
				var _120:Sprite = _125.rightArea;
				if(_120 != null){
					_12 = _120.width;
					_14 = _120.visible ? _7 : 0;
					_120.visible = true;
					if(_12 != _14){
						_15 = _125["__tweenRight"];
						if(_15 == null){
							_15 = _125["__tweenRight"] = new Tween(_120,"width",function(_15:Number, _12:Number, _13:Number, _14:Number):Number{
								return _13/2 * ( Math.sin( Math.PI * (_15/_14-0.5) ) + 1 ) + _12;  
							},_12,_14,0.25,true,80);
							_15.addEventListener(TweenEvent.MOTION_CHANGE,function(e:TweenEvent){
								var _25:Sprite = e.currentTarget.obj;
								var _138:BorderLayoutPanel = BorderLayoutPanel(_25.parent);
								var _152:Sprite = _138.leftArea;
								var _16:Number = _152 != null ? _152.x : 0;
								_25.x = _138.skin.width - _16 - _25.width;
							});
						}else if(_15.finish != _14){
							_15.begin = _12;
							_15.finish = _14;
							_15.start();
						}
					}
				}
			}
			ToolBar.prototype._onDragStop = function(evt:Event):void{
				var _121:ToolBar = ToolBar.prototype._currentTarget;
				_121.stage.removeEventListener(MouseEvent.MOUSE_MOVE, _121._onDragOver);
				_121.stage.removeEventListener(MouseEvent.MOUSE_UP, _121._onDragStop);
				var _125:BorderLayoutPanel = BorderLayoutPanel(_121.parent);
				delete _125["__tweenTop"];
				delete _125["__tweenBottom"];
				delete _125["__tweenLeft"];
				delete _125["__tweenRight"];
			}
		}
	}
}

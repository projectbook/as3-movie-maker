package app.components
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class CommonToggleButton extends TToggleButton
	{
		private static const TF_LABEL:String = "tf_label";
		private static const DURATION_SHOW:Number = 0.3; //播放的时间
		private var _ui:DisplayObject;
		private var _label:String = "";
		
		protected var _onUp:MovieClip; // 按钮的正常状态
		protected var _onOver:MovieClip; // 按钮的划过状态
		
		protected var _onUpSelect:MovieClip; // 按钮的选中状态
		protected var _onOverSelect:MovieClip; // 按钮的选中的划过状态
		
		public function CommonToggleButton(ui:DisplayObject, label:String="", _defaultHandler:Function=null, params:Array=null, _select:Boolean = false,underlay:Boolean=true)
		{
			_ui = ui;
			super(ui, _defaultHandler, params,underlay);
			selected = _select;
			this.label = label;
		}
		
		override protected function initView():void
		{
			super.initView();
			
			_onUp = _ui["mc_onUp"];
			_onOver = _ui["mc_onOver"];
			_onUpSelect = _ui["mc_onUpSelect"];
			_onOverSelect = _ui["mc_onOverSelect"];
			updateState();
		}
		
		/**
		 * 设置按钮的文本 
		 * @return 
		 * 
		 */		
		public function get label():String
		{
			return this._label;
		}
		
		public function set label(value:String):void
		{
			this._label= value;
			updateLabel();
		}
		
		private function updateLabel():void
		{
			if(label == "") return;
			if(_onUp.hasOwnProperty(TF_LABEL)) _onUp[TF_LABEL].text = label;
			if(_onOver && _onOver.hasOwnProperty(TF_LABEL)) _onOver[TF_LABEL].text = label;
			if(_onUpSelect.hasOwnProperty(TF_LABEL)) _onUpSelect[TF_LABEL].text = label;
			if(_onOverSelect && _onOverSelect.hasOwnProperty(TF_LABEL)) _onOverSelect[TF_LABEL].text = label;
		}
		
		override protected function updateState(event:MouseEvent=null):void
		{
			var upAlpha:Boolean = !_selected;
			var overAlpha:Boolean = !_selected && _over;
			
			var upSelectAlpha:Boolean = _selected;
			var overSelectAlpha:Boolean = _selected && _over;
			
			TweenLite.to(_onUp, DURATION_SHOW, {autoAlpha:upAlpha?1:0});
			_onOver && TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:overAlpha?1:0});
			
			TweenLite.to(_onUpSelect, DURATION_SHOW, {autoAlpha:upSelectAlpha?1:0});
			_onOverSelect && TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:overSelectAlpha?1:0});
			
//			if(_over){
//				overAlpha = 1;
//				overSelectAlpha = 1;
//				
//				TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:1});
//				TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:1});
//			}else{
//				overAlpha = 0;
//				overSelectAlpha = 0;
//				
//				TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:0});
//				TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:0});
//			}
//			
		}
		
		private function updateSelected(selected:Boolean):void
		{
			var normalAlpha:Number = selected?0:1;
			var selectAlpha:Number = selected?1:0;
			
			_onOver && TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:normalAlpha});
			TweenLite.to(_onUp, DURATION_SHOW, {autoAlpha:normalAlpha});
			
			_onOverSelect && TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:selectAlpha});
			TweenLite.to(_onUpSelect, DURATION_SHOW, {autoAlpha:selectAlpha});
			
			_onOver.visible = _onUp.visible = true;
			_onOverSelect.visible = _onUpSelect.visible = false;
		}
		
		private function onSelected():void
		{
			_onUp.visible = false;
			_onOverSelect.visible = false;
			
			if(_onOver)_onOver.visible = false;
			if(_onOverSelect)_onOverSelect.visible = true;
		}
		
		protected function onOut():void
		{
			_onOver && TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:0});
			_onOverSelect && TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:0});
		}
		
		protected function onOver():void
		{
			_onOver && TweenLite.to(_onOver, DURATION_SHOW, {autoAlpha:1});
			_onOverSelect &&TweenLite.to(_onOverSelect, DURATION_SHOW, {autoAlpha:1});
		}
		
		
		override public function dispose():void
		{
			super.dispose();
			_onUp = null;
			_onOver = null;
			_onUpSelect = null;
			_onOverSelect = null;
		}
		
	}
}
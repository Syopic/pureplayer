package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class ProgressBar extends Sprite{
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlayedBar")]
		private var PlayedBar:Class;
		
		private var progressBarMc:MovieClip;
		private var barMc:MovieClip;
		private var sliderMc:MovieClip;
		private var bufferMc:MovieClip;
		
		public function ProgressBar() {
			progressBarMc = new PlayedBar();
			addChild(progressBarMc);
			barMc = progressBarMc["bar"];
			bufferMc = progressBarMc["bufferBar"];
			sliderMc = progressBarMc["slider"];
			sliderMc.buttonMode = true;
		}
		
		private function initListeners():void {
			sliderMc.addEventListener(MouseEvent.MOUSE_DOWN, function():void {
				root.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
			});
			UIManager.instance.addEventListener(MouseEvent.MOUSE_UP, function():void {
				root.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
			});
			
		}
		
		public function setSliderPosition(bufferTime:Number, duration:Number):void {
			sliderMc.y = sliderMc.height-2;
			sliderMc.x = (barMc.width / duration) * bufferTime;
		}
		
		private function sliderDrop():void {
			sliderMc.stopDrag();
		}
		
		private function mouseMoveHandler(event:MouseEvent):void {
			var pt:Point = new Point(event.stageX, event.stageY);
			pt = globalToLocal(pt);
				
			sliderMc.x = Math.min(Math.max(pt.x, 0), barMc.width);
		}
		
		public function setWidth(value:Number):void {
			barMc.width = value;
			bufferMc.width = value/2;
			initListeners();
			setSliderPosition(100, 0)
		}

	}
}
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
		private var isMouseActive:Boolean = false;
		private var duration:Number;
		
		
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
				isMouseActive = true;
				UIManager.instance.videoArea.stop();
				UIManager.instance.controlPanel.playStopButton.gotoAndStop("play");
			});
			sliderMc.addEventListener(MouseEvent.MOUSE_UP, function():void {
				if (isMouseActive) {
					root.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
					isMouseActive = false;
					UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
					UIManager.instance.videoArea.play();
					UIManager.instance.controlPanel.playStopButton.gotoAndStop("pause");
				}
			});
			
			progressBarMc.addEventListener(MouseEvent.MOUSE_DOWN, function():void {
				sliderMc.x = progressBarMc.mouseX; 
				trace(barMc.mouseX);
				UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
			});
			
		}
		
		public function setSliderPosition(bufferTime:Number, _duration:Number):void {
			duration = _duration;
			if (!isMouseActive) {
				sliderMc.y = sliderMc.height - 1;
				sliderMc.x = (barMc.width / duration) * bufferTime;
			}
		}
		
		public function setBufferPosition(loaded:Number, total:Number):void {
			bufferMc.width = (barMc.width / total) * loaded;
		}
		
		private function sliderDrop():void {
			sliderMc.stopDrag();
		}
		
		private function mouseMoveHandler(event:MouseEvent):void {
			var pt:Point = new Point(event.stageX, event.stageY);
			pt = globalToLocal(pt);
				
			sliderMc.x = Math.min(Math.max(pt.x, 0), barMc.width);
			UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
		}
		
		public function setWidth(value:Number):void {
			barMc.width = value;
			bufferMc.width = value/2;
			
			barMc.y = Math.round(15 - barMc.height/2);
			bufferMc.y = Math.round(15 - bufferMc.height/2);
			
			initListeners();
			setSliderPosition(100, 0)
		}

	}
}
package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ua.com.syo.data.LibraryData;
	
	public class ProgressBar extends Sprite {
		
		private var progressBarMc:MovieClip;
		private var barMc:MovieClip;
		private var sliderMc:MovieClip;
		private var bufferMc:MovieClip;
		public var isMouseActive:Boolean = false;
		private var duration:Number;
		
		
		public function ProgressBar() {
			progressBarMc = new LibraryData.PlayedBar();
			addChild(progressBarMc);
			barMc = progressBarMc["bar"];
			bufferMc = progressBarMc["bufferBar"];
			sliderMc = progressBarMc["slider"];
			barMc.buttonMode = true;
			sliderMc.buttonMode = true;
			setBufferPosition(1, 1000);
			setSliderPosition(1, 1000);
		}
		
		private function initListeners():void {
			sliderMc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownClickHandler);
				
			
			progressBarMc.addEventListener(MouseEvent.MOUSE_DOWN, function():void {
				sliderMc.x = progressBarMc.mouseX; 
				UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
			});
			
		}
		
		
		private function mouseDownClickHandler(event:MouseEvent):void {
			UIManager.instance.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
			isMouseActive = true;
			UIManager.instance.videoArea.stop();
			UIManager.instance.controlPanel.playStopButton.gotoAndStop("play");
			
			UIManager.instance.addEventListener(Event.MOUSE_LEAVE, function():void {
				reInit();
			});
			root.addEventListener(MouseEvent.MOUSE_UP, mouseUpClickHandler);
		}
		
		private function mouseUpClickHandler(event:MouseEvent):void {
			reInit();
		}
		
		private function reInit():void {
			if (isMouseActive) {
				UIManager.instance.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				root.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpClickHandler);
				isMouseActive = false;
				UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
				UIManager.instance.videoArea.play();
				UIManager.instance.startImage.visible = false;
				UIManager.instance.controlPanel.playStopButton.gotoAndStop("pause");
			}
		}
		
		public function setSliderPosition(bufferTime:Number, _duration:Number):void {
			if (bufferTime <= _duration) {
				duration = _duration;
				if (!isMouseActive) {
					sliderMc.y = sliderMc.height - 1;
					sliderMc.x = (barMc.width / duration) * bufferTime;
				}
			}
		}
		
		public function setBufferPosition(loaded:Number, total:Number):void {
			bufferMc.width = (barMc.width / total) * loaded;
		}
		
		private function sliderDrop():void {
			sliderMc.stopDrag();
		}
		
		private function mouseMoveHandler(event:MouseEvent):void {
			if (isMouseActive) {
				var pt:Point = new Point(event.stageX, event.stageY);
				pt = globalToLocal(pt);
					
				sliderMc.x = Math.min(Math.max(pt.x, 0), barMc.width);
				UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
			}
		}
		
		public function setWidth(value:Number):void {
			barMc.width = value;
			bufferMc.width = 1;
			
			barMc.y = Math.round(15 - barMc.height/2);
			bufferMc.y = Math.round(15 - bufferMc.height/2);
			
			initListeners();
		}

	}
}
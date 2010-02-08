package ua.com.syo.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import ua.com.syo.data.Globals;
	import ua.com.syo.data.LibraryData;
	import ua.com.syo.view.events.ControlEvent;

	public class ControlPanel extends Sprite {
		
		public var controlPanelBg:Sprite;
		public var playStopButton:MovieClip;
		private var embedButton:MovieClip;
		private var fullscreenButton:MovieClip;
		private var volumeButton:MovieClip;
		private var scoreboard:MovieClip;
		public var progressBar:ProgressBar;
		
		public var scoreTextField:TextField;
		
		public function ControlPanel() {
			
			controlPanelBg = new LibraryData.ControlPanelBg();
			addChild(controlPanelBg);
			
			playStopButton = new LibraryData.PlayStopButton();
			addChild(playStopButton);
			playStopButton.addEventListener(MouseEvent.CLICK, playStopButtonClickHandler);
			
			embedButton = new LibraryData.EmbedButton();
			addChild(embedButton);
			embedButton.addEventListener(MouseEvent.CLICK,embedButtonClickHandler);
			
			fullscreenButton = new LibraryData.FullscreenButton();
			addChild(fullscreenButton);
			
			volumeButton = new LibraryData.VolumeButton();
			addChild(volumeButton);
			
			scoreboard = new LibraryData.Scoreboard();
			addChild(scoreboard);
			scoreTextField = scoreboard["scoreTextField"];
			
			progressBar = new ProgressBar();
			addChild(progressBar);
			
			enableControls();
			arrangeControls();
		}
		
		private function enableControls():void {
			playStopButton.gotoAndStop("play");
			initButtonListeners(playStopButton);
			initButtonListeners(embedButton);
			initButtonListeners(fullscreenButton);
			initButtonListeners(volumeButton);
			
			volumeButton.gotoAndStop("collapse");
			MovieClip(volumeButton["slider"]).visible = false;
			MovieClip(volumeButton["bar"]).visible = false;
			volumeButton.buttonMode = true;
			volumeButton.addEventListener(MouseEvent.MOUSE_OVER, function():void {
				volumeButton.gotoAndStop("expand");
				MovieClip(volumeButton["slider"]).visible = true;
				MovieClip(volumeButton["bar"]).visible = true;
				//MovieClip(volumeButton["tint"]).alpha = 0.1;
					MovieClip(volumeButton["slider"]).addEventListener(MouseEvent.MOUSE_DOWN, function():void {
						root.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
						isMouseActive = true;
					});
					MovieClip(volumeButton["slider"]).addEventListener(MouseEvent.MOUSE_UP, function():void {
						if (isMouseActive) {
							root.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, true);
							isMouseActive = false;
							
							var v:Number = 1 - (MovieClip(volumeButton["slider"]).y + 50) / 50;
							UIManager.instance.videoArea.setVolume(v);
						}
					});
				});
				
			volumeButton.addEventListener(MouseEvent.MOUSE_OUT, function():void {
				volumeButton.gotoAndStop("collapse");
				MovieClip(volumeButton["slider"]).visible = false;
				MovieClip(volumeButton["bar"]).visible = false;
				});
			
			fullscreenButton.addEventListener(MouseEvent.CLICK, function():void {
				if (root.stage.displayState == StageDisplayState.FULL_SCREEN) {
					root.stage.displayState = StageDisplayState.NORMAL;
				} else {
					root.stage.displayState = StageDisplayState.FULL_SCREEN;
				}
				});
				
				
		}
		private var isMouseActive:Boolean = false;
		private function mouseMoveHandler(event:MouseEvent):void {
			var pt:Point = new Point(event.stageX, event.stageY - 10);
			pt = globalToLocal(pt);
				
			MovieClip(volumeButton["slider"]).y = Math.min(Math.max(pt.y, -50), 0);
			var v:Number = 1 - (MovieClip(volumeButton["slider"]).y + 50) / 50;
			UIManager.instance.videoArea.setVolume(v);
			//UIManager.instance.videoArea.seekStream(duration/barMc.width * sliderMc.x);
		}
		
		private var leftIndent:Number;
		private var rightIndent:Number;
		
		public function arrangeControls():void {
			
			controlPanelBg.width = Globals.stageWidth;
			controlPanelBg.height = Globals.controlBarHeight;
			
			y = Globals.stageHeight - Globals.controlBarHeight;
			
			leftIndent = 15;
			rightIndent = Globals.stageWidth;
			
			playStopButton.x = leftIndent;
			playStopButton.y = 10;
			
			leftIndent += playStopButton.width + 15; 
			
			
			embedButton.x = rightIndent - embedButton.width - 10;
			embedButton.y = 15;
			
			rightIndent = embedButton.x; 
			
			
			fullscreenButton.x = rightIndent - fullscreenButton.width - 10;
			fullscreenButton.y = 12;
			
			rightIndent = fullscreenButton.x; 
			
			volumeButton.x = rightIndent - volumeButton.width - 11;
			volumeButton.y = 11;
			
			rightIndent = volumeButton.x; 
			
			scoreboard.x = rightIndent - scoreboard.width - 17;
			scoreboard.y = 10;
			
			rightIndent = scoreboard.x - 10; 
			
			progressBar.x = leftIndent;
			progressBar.y = 10;
			progressBar.setWidth(rightIndent - leftIndent); 
		}
		
		private function initButtonListeners(b:MovieClip):void {
			b.buttonMode = true;
			if (MovieClip(b["tint"])) {
				MovieClip(b["tint"]).visible = false;
				b.addEventListener(MouseEvent.MOUSE_OVER, function():void {MovieClip(b["tint"]).visible = true;});
				b.addEventListener(MouseEvent.MOUSE_OUT, function():void {MovieClip(b["tint"]).visible = false;});
			}
		}
		
		
		
		private function playStopButtonClickHandler(event:MouseEvent):void {
			var e:ControlEvent = new ControlEvent(ControlEvent.CONTROL_ACTION);
			if (playStopButton.currentLabel == "pause") {
				e.actionType = "pause";
				playStopButton.gotoAndStop("play");
			} else {
				e.actionType = "play";
				playStopButton.gotoAndStop("pause");
			}
			dispatchEvent(e);
		}
		
		
		private function embedButtonClickHandler(event:MouseEvent):void {
			//UIManager.instance.showPlayListView();
			UIManager.instance.showEmbedView();
		}
		
	}
}
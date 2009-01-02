package ua.com.syo.view {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import ua.com.syo.data.Globals;
	import ua.com.syo.model.VideoItem;

	public class PlaylistView extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlaylistItem")]
		private var PlaylistItem:Class;
		
		private var thumbContainer:Sprite;
		private var scrollSpeed:Number;
		private var incr:int = 0;
		private var isScroll:Boolean = true;
		
		public function PlaylistView() {
			thumbContainer = new Sprite();
			addChild(thumbContainer);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function addItems(items:Dictionary):void {
			for each (var i:Object in items) {
				//(i as VideoItem)
				var it:Sprite = new PlaylistItem();
				var itt:DisplayObject = thumbContainer.addChild(it);
				itt.x = incr*130;
				itt.y = Math.round((Globals.stageHeight / 2) - 20 - itt.height / 2);
				incr++;
			}
			
			if (incr*130 < Globals.stageWidth) {
				isScroll = false;
				thumbContainer.x = Globals.stageWidth / 2 - incr*130 / 2 + 10;
			}
		}
		
		private function enterFrameHandler(event:Event):void {
			scrollSpeed = Math.round((Globals.stageWidth / 2 - mouseX) / 30);
			if (isScroll && 
				mouseY > (Globals.stageHeight / 2 - 80) && 
				mouseY < (Globals.stageHeight / 2 + 80)
				) {
				thumbContainer.x += scrollSpeed;
				if (thumbContainer.x > 10) {
					thumbContainer.x = 10;
				}
				if (thumbContainer.x < -(incr*130 - Globals.stageWidth)) {
					thumbContainer.x = -(incr*130 - Globals.stageWidth);
				}
			}
		}
	}
}
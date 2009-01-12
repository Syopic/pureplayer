package ua.com.syo.view {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import ua.com.syo.data.CurrentData;
	import ua.com.syo.model.VideoItem;
	
	public class PlaylistItem extends Sprite {
		
		[Embed(source = "/../assets/library.swf" , symbol = "PlaylistItem")]
		private var ListItem:Class;
		
		private var listItem:Sprite;
		private var thumbContainer:MovieClip;
		private var loader:Loader;
		private var titleTF:TextField;
		
		public function PlaylistItem(vi:VideoItem) {
			listItem = new ListItem();
			titleTF = listItem["titleTF"];
			thumbContainer = listItem["thumbC"];
			titleTF.text = vi.title;
			addChild(listItem);
			loadThumb(vi.thumbUrl);
			
			var tint:MovieClip = listItem["tint"];
			tint.visible = false;
			listItem.buttonMode = true;
			
			listItem.addEventListener(MouseEvent.MOUSE_OVER, function():void {tint.visible = true;});
			listItem.addEventListener(MouseEvent.MOUSE_OUT, function():void {tint.visible = false;});
		}
		
		private function loadThumb(url:String):void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoadedHandler);
			var request:URLRequest = new URLRequest(CurrentData.instance.rootURL + url);
			loader.load(request);
		}
		
		private function thumbLoadedHandler(event:Event):void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, thumbLoadedHandler);
			loader.content.x = 10;
			loader.content.y = 10;
			thumbContainer.addChild(loader.content);
		}
	}
}
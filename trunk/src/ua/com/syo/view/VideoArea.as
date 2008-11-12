package ua.com.syo.view {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class VideoArea {
		
		[Embed(source = "/../assets/library.swf" , symbol = "VideoAreaBg")]
		private var VideoAreaBg:Class;
		
		private var bg:Sprite;
		private var video:Video;
		
		private var container:Sprite;
		
		private var connection:NetConnection;
		private var stream:NetStream;
		
		public function VideoArea(_container:Sprite)	{
			container = _container;
			bg = new VideoAreaBg();
			container.addChild(bg);
			
			connection = new NetConnection();
            connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            connection.connect(null);
		}
		
		public function setSize(w:Number, h:Number):void {
			bg.width = video.width = w;
			bg.height = h;
		}
		
		private var videoURL:String = "../assets/video.flv";
		
        private function netStatusHandler(event:NetStatusEvent):void {
            switch (event.info.code) {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + videoURL);
                    break;
                    
            }
        }
        
        private function connectStream():void {
        	var customClient:Object = new Object();
			customClient.onMetaData = metaDataHandler;

        	
            stream = new NetStream(connection);
            stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
            
            video = new Video();
            video.attachNetStream(stream);
            
            stream.client = customClient;

            stream.play(videoURL);
            container.addChild(video);
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
            trace("securityErrorHandler: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            trace(event.text);
        }
		
		private function metaDataHandler(infoObject:Object):void {
		    video.y = Math.round(bg.height/2 - video.height/2);
		}

		
	}
}
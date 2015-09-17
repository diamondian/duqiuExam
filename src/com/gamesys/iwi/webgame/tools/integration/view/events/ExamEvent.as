/**
 * Created by MyPC on 2015/9/16.
 */
package com.gamesys.iwi.webgame.tools.integration.view.events
{
	import flash.events.Event;

	public class ExamEvent extends Event
	{
		private var _examID:String;
		private var _data:Object;
		public function ExamEvent(type:String, examID:String,data:Object = null)
		{
			super(type, bubbles, cancelable);
			_examID = examID;
			_data = data;
		}

		public function get examID():String
		{
			return _examID;
		}

		public function set examID(value:String):void
		{
			_examID = value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}
	}
}

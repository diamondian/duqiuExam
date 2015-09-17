/**
 * Created by MyPC on 2015/9/17.
 */
package com.gamesys.iwi.webgame.tools.integration.models
{
	public class Question
	{
		public var bodyText:String;
		public var answer:Object;
		public var correctAnswer:Object;

		public function get isCorrect():Boolean
		{
			return answer === correctAnswer;
		}


		public function toString():String
		{
			return "Question: "+bodyText + ". answer:"+answer;
		}
	}
}

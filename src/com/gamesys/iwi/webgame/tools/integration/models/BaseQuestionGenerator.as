/**
 * Created by MyPC on 2015/9/17.
 */
package com.gamesys.iwi.webgame.tools.integration.models
{
	public class BaseQuestionGenerator
	{
		protected var _config:Object;

		public function BaseQuestionGenerator(config:Object)
		{
			_config = config;
		}

		public function getNewQuestion():Question
		{

		}
	}
}

/**
 * Created by MyPC on 2015/9/17.
 */
package com.gamesys.iwi.webgame.tools.integration.models.math
{
	import com.gamesys.iwi.webgame.tools.integration.models.BaseQuestionGenerator;
	import com.gamesys.iwi.webgame.tools.integration.models.Question;

	public class MathQuestionGenerator extends BaseQuestionGenerator
	{
		public function MathQuestionGenerator(config:Object)
		{
			super(config);
		}

		override public function getNewQuestion():Question
		{
			var q:Question = new Question();


			 var hasJiafa:Boolean = _config.hasJiafa;
			 var hasJianfa:Boolean = _config.hasJianfa;
			 var hunhe:Boolean = _config.hunhe;
			 var hasXiaoshu:Boolean = _config.hasXiaoshu;
//			 var hasFushu:Boolean = _config.hasFushu;
			 var range:int = _config.range;
			 var times:int = _config.times;

			var calculation:Number;

			for (var i:int = 0; i < times; i++) {

				var isPositiveNumber:Boolean =
						(calculation != NaN && hasJianfa && hunhe)?getRandomResult():true;
				var number:Number = getRandomNumber(
						isPositiveNumber,hasXiaoshu,range);
				if(calculation == NaN)
				{
					calculation = number;
					q.bodyText = calculation + "";
				}
				else
				{
					calculation += number;
					if(number < 0)
					{
						range += number;
					}
					q.bodyText += getOperatorText(number) + number;
				}

			}

			q.answer = calculation;
			q.bodyText += " = ";


			return q;
		}

		private function getRandomNumber(isPositive:Boolean,allowDecimal:Boolean,range:Number):Number
		{
			var number:Number = range * Math.random();
			allowDecimal || (number = Math.round(number));
			isPositive || (number *= -1);
			
			return number;
		}

		private function getRandomResult():Boolean
		{
			return Math.random() < 0.5;
		}

		private function getOperatorText(value:Number):String
		{
			return (value < 0)?" - ":" + ";
		}
	}
}

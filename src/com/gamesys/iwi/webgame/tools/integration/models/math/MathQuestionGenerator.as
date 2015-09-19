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
			var finalRange:Number = range;

			var calculation:Number;

			for (var i:int = 0; i < times; i++) {

				var isPositiveNumber:Boolean =
						(!isNaN(calculation) && hasJianfa && hunhe) ? getRandomResult() : true;
				if (!isNaN(calculation)) {
					if (isPositiveNumber) {
						finalRange = range - calculation;
					}
					else {
						finalRange = calculation;
					}
				}
				var number:Number = getRandomNumber(isPositiveNumber, hasXiaoshu, finalRange);
				if (isNaN(calculation)) {
					calculation = number;
					q.bodyText = calculation + "";
				}
				else {
					calculation += number;
					q.bodyText += getOperatorText(number) + Math.abs(number);
				}

			}

			q.correctAnswer = calculation;
			q.bodyText += " = ";

			trace(q);
			return q;
		}

		private function getRandomNumber(isPositive:Boolean, allowDecimal:Boolean, range:Number):Number
		{
			var number:Number = range * Math.random();
			allowDecimal || (number = Math.round(number));
			isPositive || (number *= -1);
			number == 0 && (number = 1);

			return number;
		}

		private function getRandomResult():Boolean
		{
			return Math.random() < 0.5;
		}

		private function getOperatorText(value:Number):String
		{
			return (value < 0) ? " - " : " + ";
		}
	}
}

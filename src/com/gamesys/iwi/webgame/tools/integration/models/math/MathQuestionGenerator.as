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

			/*
			 examData.hasJiafa = checkBox_jiafa.selected;
			 examData.hasJianfa = checkBox_jianfa.selected;
			 examData.hunhe = checkBox_jiafa.selected && checkBox_jianfa.selected && checkBox_hunhe.selected;
			 examData.hasXiaoshu = checkBox_xiaoshu.selected;
			 examData.hasFushu = checkBox_fushu.selected;
			 examData.range = stepper.value;
			 examData.times = stepper2.value;
			 */



			return q;
		}

		private function getRandomNumber(isPositive:Boolean,allowDecimal:Boolean,range:Number):Number
		{
			return 1;
		}

		private function getRandomOperator():Boolean
		{
			return Math.random() < 0.5;
		}

		private function getOperatorText(isMinus:Boolean):String
		{
			return isMinus?" - ":" + ";
		}
	}
}

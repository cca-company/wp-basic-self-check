package next.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import core.mvc.AbstractController;
import core.mvc.ModelAndView;
import core.utils.ServletRequestUtils;
import next.dao.AnswerDao;
import next.dao.QuestionDao;
import next.model.Answer;
import next.model.Question;

public class DeleteQuestionController extends AbstractController  {
	QuestionDao questionDao = QuestionDao.getInstance();
	AnswerDao answerDao = AnswerDao.getInstance();
	List<Answer> answerList;

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long questionId = ServletRequestUtils.getLongParameter(request, "questionId");
		Question question = questionDao.findById(questionId);
		answerList = answerDao.findOtherWriterAnswered(questionId, question.getWriter());
		
		ModelAndView mov = jsonView();
		if(answerList.isEmpty()){
			questionDao.delete(questionId);
			mov.addObject("result", true);
		}else{
			mov.addObject("result", false);			
		}

		return mov;
	}

}

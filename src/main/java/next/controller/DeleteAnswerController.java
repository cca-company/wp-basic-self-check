package next.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import core.mvc.AbstractController;
import core.mvc.ModelAndView;
import core.utils.ServletRequestUtils;
import next.dao.AnswerDao;
import next.dao.QuestionDao;
import next.model.Answer;

public class DeleteAnswerController extends AbstractController {
	AnswerDao answerDao = AnswerDao.getInstance();
	QuestionDao questionDao = QuestionDao.getInstance();

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long answerId = ServletRequestUtils.getLongParameter(request, "answerId");
		Answer answer = answerDao.findById(answerId);
		
		answerDao.delete(answerId);
		questionDao.decreaseComment(answer.getQuestionId());
		
		return jsonView();
	}

}

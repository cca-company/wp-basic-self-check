package next.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import core.mvc.AbstractController;
import core.mvc.ModelAndView;
import core.utils.ServletRequestUtils;
import next.dao.QuestionDao;
import next.model.Question;

public class MoreListController extends AbstractController {
	QuestionDao questionDao = QuestionDao.getInstance();
	List<Question> questions;

	@Override
	public ModelAndView execute(HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		int page = ServletRequestUtils.getIntParameter(request, "page");
		int limit = 5;
		int offset = page * limit;
		questions = questionDao.findAllByPage(offset, limit);
		
		ModelAndView mav = jsonView();
		mav.addObject("questions", questions);
		return mav;
	}

}

from flask import Blueprint
from bot.chat.chat_bot import ChatBot


bp = Blueprint('bot', __name__, url_prefix='/bot')

@bp.route('test')
def test():

    dic = {
        "no" : 1,
        "title" : "hihi",
        "body" : "ndfsdf",
        "aaa" : "cv,mcv"
    }

    return "hihi"


@bp.route("question")
def test2():
  bot = ChatBot()
  answer = bot.run_chatbot("안녕")
  result = "{message: "+ answer +"}"
  return result

@bp.route("token")
def test3():
    bot = ChatBot()
    token = bot.get_tokenizer()
    print(token.word_index)

    return "hihihih"

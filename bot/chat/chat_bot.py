from bot.chat.Seq2seq import Seq2seq
from bot.chat import constants as co
import re
import numpy as np
from joblib import load
from tensorflow.keras.preprocessing.sequence import pad_sequences
from konlpy.tag import Okt
from flask import current_app

class ChatBot():

    def __init__(self):
        base_dir = current_app.root_path
        name = '/resource/tokenizer'
        self.tokenizer = load(base_dir + name)

        self.okt = Okt()
        self.DATA_LENGTH = co.DATA_LENGTH
        START_TOKEN = self.tokenizer.word_index['<START>']
        END_TOKEN = self.tokenizer.word_index['<END>']

        self.bot = Seq2seq(co.UNITS, co.VOCAB_SIZE, co.EMBEDDING_DIM, co.TIME_STEPS, START_TOKEN, END_TOKEN)
        self.bot.load_weights(base_dir + '/resource/test')


    def get_tokenizer(self):
        return self.tokenizer

    def get_bot(self):
        return self.bot
    ## 모델이 예측한 인코딩된 값을 다시 문자로 디코딩 해주는 함수
    def convert_index_to_text(self, indexes, end_token):
        sentence = ''
        for index in indexes:  ## 문장의 순서
            if index == end_token:  ## 문장의 마지막이면 종료
                break
            if index > 0 and self.tokenizer.index_word[index] is not None:  ## 단아 사전에 존재하고 올바른 인덱스라면
                sentence += self.tokenizer.index_word[index]  # 최종 문자열에 이어 붙인다.
            else:
                sentence += ''  # 없는 거면 공백.

            sentence += ' '  # 한 형태소가 끝나면 띄어쓰기
        return sentence

    def run_chatbot(self, question):
        question_inputs = self.make_question(question)
        results = self.make_prediction(self.bot, question_inputs)
        print(results)
        results = self.convert_index_to_text(results, '<END>')
        return results

    def make_question(self, sentence):
        sentence = self.clean_and_morph(sentence)
        question_sequence = self.tokenizer.texts_to_sequences([sentence])
        print(question_sequence)
        question_padded = pad_sequences(question_sequence, maxlen=co.MAX_LENGTH, truncating=co.TRUNCATING, padding=co.PADDING)

        return question_padded

    def clean_and_morph(self, sentence, is_question=True):
        ## 한글만 남기기
        sentence = self.clean_sentence(sentence)

        ## 형태소로 쪼개기
        sentence = self.process_morph(sentence)

        if is_question:
            return sentence

        else:
            ## 후에 토크나이저하기 위해서는 공백이 꼭 들어가야 함.
            return ('<START> ' + sentence, sentence + ' <END>')

    def make_prediction(self, model, question_inputs):
        results = model(inputs=question_inputs, training=False)
        results = np.asarray(results).reshape(-1)
        return results

    def process_morph(self, sentence):
      return ' '.join(self.okt.morphs(sentence))

    def clean_sentence(self, sentence):
        sentence = re.sub(r'[^0-9ㄱ-ㅎㅏ-ㅣ가-힣 ]', r'', sentence)
        return sentence
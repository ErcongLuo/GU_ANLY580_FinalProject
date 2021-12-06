from transformers import BertTokenizer, BertForSequenceClassification
from fastapi import FastAPI
from typing import Optional
from pydantic import BaseModel
import torch
import numpy as np

label_names = {0 : 'fear',
              1 : 'anger',
              2 : 'happiness',
              3 : 'sadness',
              4 : 'no specific emotion'}

class ModelInference:
    def __init__(self, args):
        self.tokenizer = BertTokenizer.from_pretrained('bert-base-cased')
        self.model = BertForSequenceClassification.from_pretrained('emotion_epochs_6_lr_3e-5_uncleaned_cased', num_labels = 5)
    
    def predict(self, message):
        inputs = self.tokenizer.encode_plus(message,add_special_tokens = True,truncation = True,padding = 200,return_attention_mask = True,return_tensors = "pt")
        labels = torch.tensor([1]).unsqueeze(0)
        outputs = self.model(**inputs, labels=labels)
        res = torch.nn.Softmax(dim = 1)(outputs[1]).detach().numpy().tolist()

        return res

class SimpleMessage(BaseModel):
    text: Optional[str] = "hello, world"

model_class = ModelInference(1)


#print(model_class.predict("hello, world"))



app = FastAPI()

@app.post("/prediction")
async def run_prediction(message: SimpleMessage):
    softmax = model_class.predict(message.text)
    return {'prediction': label_names[np.argmax(softmax[0])],
            'confidence': softmax[0][np.argmax(softmax[0])],
           'softmax_values': {
               label_names[0] : softmax[0][0],
               label_names[1] : softmax[0][1],
               label_names[2] : softmax[0][2],
               label_names[3] : softmax[0][3],
               label_names[4] : softmax[0][4],
           }}


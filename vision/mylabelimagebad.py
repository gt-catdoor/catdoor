
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse

import numpy as np
import tensorflow as tf
import cv2
import pyscreenshot as ImageGrab
from tkinter import *
import threading
from PIL import Image
from PIL import ImageTk
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# # Use the application default credentials
# cred = credentials.ApplicationDefault()
# firebase_admin.initialize_app(cred, {
#   'projectId': "catdoor-642e4",
# })

# Use a service account






class gui:
  def __init__(self, w, doc_ref):
    image_label = None
    img_str = StringVar()
    image_result_label = Label(w, textvariable=img_str).grid(row=0, column=1)
    vc = visionCore(image_label, img_str, doc_ref)
    start_vision_label = Label(w, text = "Start Detection!: ").grid(row = 1, column = 0, columnspan = 1)
    start_vision_button = Button(w, text="Start", command = vc.runVision).grid(row=1,column=1, columnspan=1,pady = 5)
    end_vision_button = Button(w, text="End", command = vc.endVision).grid(row=1,column=2, columnspan=1,pady = 5)
    # self.canvas = Canvas(w, width = 700, height = 500)
    # self.canvas.pack()
    # self.canvas.create_image(0, 0, image = self.photo, anchor = tkinter.NW)
    # self.canvas.itemconfig(self.image_on_canvas, image = ...)





class visionCore:
  def __init__(self, image_label, img_str, doc_ref):
    self.stop = threading.Event()
    self.t = threading.Thread(target=self._runVision)
    self.image_label = image_label
    self.img_str = img_str
    self.doc_ref = doc_ref

  def load_graph(self, model_file):
    graph = tf.Graph()
    graph_def = tf.GraphDef()

    with open(model_file, "rb") as f:
      graph_def.ParseFromString(f.read())
    with graph.as_default():
      tf.import_graph_def(graph_def)

    return graph

  def load_labels(self, label_file):
    label = []
    proto_as_ascii_lines = tf.gfile.GFile(label_file).readlines()
    for l in proto_as_ascii_lines:
      label.append(l.rstrip())
    return label

  def runVision(self):
    if not self.t.is_alive():
      print ("run vision clicked!!")
      self.stop.clear()
      self.t = threading.Thread(target=self._runVision)
      self.t.start()

  def endVision(self):
    self.stop.set()


  def _runVision(self):
    label_file = "./tmp/v2/output_labels.txt"
    model_file = "./tmp/v2/output_graph.pb"
    input_layer = "Placeholder"
    output_layer = "final_result"
    input_width = 224
    input_height = 224
    input_mean = 0
    input_std = 255
    graph = self.load_graph(model_file)
   
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FPS, 1) 
    current_label = ""
    new_label = ""


    input_name = "import/" + input_layer
    output_name = "import/" + output_layer
    input_operation = graph.get_operation_by_name(input_name)
    output_operation = graph.get_operation_by_name(output_name)

      

    while not self.stop.is_set():
      # print("\n\n\n")
      # cap.set(3, 224)
      # cap.set(4, 224)
      ret, image_reader = cap.read()

      if ret:
        # float_caster = tf.cast(image_reader, tf.float32)
        # dims_expander = tf.expand_dims(float_caster, 0)
        # resized = tf.image.resize_bilinear(dims_expander, [input_height, input_width])
        # normalized = tf.divide(tf.subtract(resized, [input_mean]), [input_std])
        
        # sess = tf.Session()
        # result = sess.run(normalized)

        # t = result

        # with tf.Session(graph=graph) as sess:
        #   results = sess.run(output_operation.outputs[0], {
        #       input_operation.outputs[0]: t
        #   })
        # results = np.squeeze(results)
        

        # top_k = results.argsort()[-5:][::-1]
        # labels = self.load_labels(label_file)
        # for idx, sel in enumerate(top_k):
        #   # print(labels[i], results[i])
        #   if idx == 0:
        #     self.img_str.set(labels[sel] + ": " + str(results[sel]) + "\n")
        #   else:
        #     self.img_str.set(self.img_str.get() + labels[sel] + ": " + str(results[sel]) + "\n")

        # # print(top_k) ## [3 4 0 2 1]
        # # print(labels[top_k[0]]) // this is top label

        # new_label = labels[top_k[0]]

        # if current_label != new_label:
        #   if new_label == "cat":
        #     self.doc_ref.update({
        #       "cat_detected": True,
        #       "intruder_detected": False
        #     })
        #   elif new_label == "others":
        #     self.doc_ref.update({
        #       "cat_detected": False,
        #       "intruder_detected": True
        #     })

        # current_label = new_label

        img_np = np.array(image_reader)
        image = cv2.cvtColor(img_np, cv2.COLOR_BGR2RGB)
        image = Image.fromarray(image)
        image = image.resize((700, 500), Image.ANTIALIAS)
        image = ImageTk.PhotoImage(image)
        #  cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
        # cv2.imshow('image', image)
        if self.image_label is None:
          self.image_label = Label(image=image)
          self.image_label.image = image
          self.image_label.grid(row = 0, column = 0, columnspan = 1)
        else:
          self.image_label.configure(image=image)
          self.image_label.image = image  
        cv2.waitKey(500) 

    cap.release()
    cv2.destroyAllWindows()
        

cred = credentials.Certificate('serviceaccount.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

catdoor_ref = db.collection(u'CatDoor')
docs = catdoor_ref.get()

doc_id = "data"

# for doc in docs:
#   doc_id = doc.id
#   print(u'{} => {}'.format(doc.id, doc.to_dict()))


def on_snapshot(doc_snapshot, changes, read_time):
  for doc in doc_snapshot:
    print(u'Received document snapshot: {}'.format(doc.id))
    print(doc.to_dict())


doc_ref = db.collection(u'CatDoor').document(doc_id)

# Watch the document

doc_watch = doc_ref.on_snapshot(on_snapshot)

tk = Tk()
gui = gui(tk, doc_ref)
tk.mainloop()

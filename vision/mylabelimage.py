
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


class gui:
  def __init__(self, w):
    image_label = None
    vc = visionCore(image_label)
    start_vision_label = Label(w, text = "Start Detection!: ").grid(row = 1, column = 0, columnspan = 1)
    start_vision_button = Button(w, text="Start", command = vc.runVision).grid(row=1,column=1, columnspan=1,pady = 5)
    end_vision_button = Button(w, text="End", command = vc.endVision).grid(row=1,column=2, columnspan=1,pady = 5)

class visionCore:
  def __init__(self, image_label):
    self.stop = threading.Event()
    self.t = threading.Thread(target=self._runVision)
    self.image_label = image_label

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

    while not self.stop.is_set():
      print("\n\n\n")
      # cap.set(3, 224)
      # cap.set(4, 224)
      ret, image_reader = cap.read()

      float_caster = tf.cast(image_reader, tf.float32)
      dims_expander = tf.expand_dims(float_caster, 0)
      resized = tf.image.resize_bilinear(dims_expander, [input_height, input_width])
      normalized = tf.divide(tf.subtract(resized, [input_mean]), [input_std])
      sess = tf.Session()
      result = sess.run(normalized)

      t = result

      input_name = "import/" + input_layer
      output_name = "import/" + output_layer
      input_operation = graph.get_operation_by_name(input_name)
      output_operation = graph.get_operation_by_name(output_name)

      with tf.Session(graph=graph) as sess:
        results = sess.run(output_operation.outputs[0], {
            input_operation.outputs[0]: t
        })
      results = np.squeeze(results)

      top_k = results.argsort()[-5:][::-1]
      labels = self.load_labels(label_file)
      for i in top_k:
        print(labels[i], results[i])

      img_np = np.array(image_reader)
      image = cv2.cvtColor(img_np, cv2.COLOR_BGR2RGB)
      image = Image.fromarray(image)
      image = ImageTk.PhotoImage(image)
       # cv2.rectangle(img, (x, y), (x+w, y+h), (0, 255, 0), 2)
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
        


tk = Tk()
gui = gui(tk)
tk.mainloop()

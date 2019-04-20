
from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import argparse
import time
import numpy as np
import tensorflow as tf
import cv2
import pyscreenshot as ImageGrab
from tkinter import Tk, Label, Button, StringVar, IntVar, Entry
import threading
from PIL import Image
from PIL import ImageTk
# import google.cloud.firestore

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# import Server as sv

# # Use the application default credentials
# cred = credentials.ApplicationDefault()
# firebase_admin.initialize_app(cred, {
#   'projectId': "catdoor-642e4",
# })

# Use a service account


LOCKDOWN = "Lock Down"
CATIN = "Let Cats in Only"
CATOUT = "Let Cats out Only"
UNLOCK = "Unlock"
STATUS = "doorstatus"




class gui:


	def __init__(self, w, doc_ref):
		self.w = w
		self.cap = None
		self.image_label = None
		self.alreadyrunning = False
		self.img_str = StringVar()
		self.doc_ref = doc_ref

		## for timer
		self.start = 0
		self.end = 0
		self.isTimeOver = True
		self.isCounting = False
		self.delay_after_cat = IntVar()

		self.changedoor = True

		self.SERVERSTATE = ''
		self.LOCALSTATE = ''
		doc_watch = doc_ref.on_snapshot(self.on_snapshot)


		image_result_label = Label(w, textvariable=self.img_str, width=30, height=20).grid(row=0, column=1)

		delay_after_cat_label = Label(w, text = "How much seconds \ndo you want a door to be open \nafter cat is detected?").grid(row = 2, column=0)
		delay_after_cat_Entry =  Entry(w, textvariable = self.delay_after_cat, fg = "black").grid(row = 2, column = 1, columnspan = 1)
		self.delay_after_cat.set(5)

		start_vision_label = Label(w, text = "Start Detection!: ").grid(row = 3, column = 0, columnspan = 1)
		start_vision_button = Button(w, text="Start", command = self.updateinit).grid(row=3,column=1, columnspan=1,pady = 5)
		end_vision_button = Button(w, text="End", command = self.terminate).grid(row=3,column=2, columnspan=1,pady = 5)
		




	def updateinit(self):
		if not self.alreadyrunning:
			self.label_file = "./output_labels.txt"
			model_file = "./output_graph.pb"
			input_layer = "Placeholder"
			output_layer = "final_result"
			self.input_width = 224
			self.input_height = 224
			self.input_mean = 0
			self.input_std = 255
			self.graph = self.load_graph(model_file)

			self.cap = cv2.VideoCapture(0)
			self.cap.set(cv2.CAP_PROP_FPS, 1) 
			self.current_label = ""
			self.new_label = ""


			self.SERVERSTATE = self.doc_ref.get().get(STATUS)
			# print(serverdata)
			if self.SERVERSTATE == UNLOCK or self.SERVERSTATE == CATOUT:
				self.LOCALSTATE = CATOUT
			else:
				self.LOCALSTATE = LOCKDOWN

			# if self.changedoor:
			# 	sv.doorLock(self.LOCALSTATE)
			# 	self.changedoor = False


			input_name = "import/" + input_layer
			output_name = "import/" + output_layer
			self.input_operation = self.graph.get_operation_by_name(input_name)
			self.output_operation = self.graph.get_operation_by_name(output_name)
			self.alreadyrunning = True
			self.update()


	def update(self):
		ret, image_reader = self.cap.read()
		# print(ret)
		if ret:
			float_caster = tf.cast(image_reader, tf.float32)
			dims_expander = tf.expand_dims(float_caster, 0)
			resized = tf.image.resize_bilinear(dims_expander, [self.input_height, self.input_width])
			normalized = tf.divide(tf.subtract(resized, [self.input_mean]), [self.input_std])
			
			sess = tf.Session()
			result = sess.run(normalized)

			t = result

			with tf.Session(graph=self.graph) as sess:
				results = sess.run(self.output_operation.outputs[0], {
						self.input_operation.outputs[0]: t
				})
			results = np.squeeze(results)

			top_k = results.argsort()[-5:][::-1]
			labels = self.load_labels(self.label_file)
			for idx, sel in enumerate(top_k):
				# print(labels[i], results[i])
				if idx == 0:
					self.img_str.set(labels[sel] + ": " + str(results[sel]) + "\n")
				else:
					self.img_str.set(self.img_str.get() + labels[sel] + ": " + str(results[sel]) + "\n")

			# print(top_k) ## [3 4 0 2 1]
			# print(labels[top_k[0]]) // this is top label

			self.new_label = labels[top_k[0]]
			# print ("current label: " + self.current_label + "/new_label: " + self.new_label + "/")
			

				


			if self.new_label != self.current_label:	
				if self.new_label == "cat":
					if self.SERVERSTATE == UNLOCK and self.LOCALSTATE == CATOUT:
						self.changedoor = True
						self.LOCALSTATE = UNLOCK
					elif self.SERVERSTATE == CATIN and self.LOCALSTATE == LOCKDOWN:
						print(" yuu hoo ")
						self.changedoor = True
						self.LOCALSTATE = CATIN

					self.doc_ref.update({
						"cat_detected": True,
						"intruder_detected": False
					})
					self.start = time.time()
					self.isCounting = True
					self.isTimeOver = False
					print ("updating : cat is detected")
				elif self.new_label != "cat" and self.new_label != "others": ## intruders
					if self.isTimeOver:
						if self.SERVERSTATE == UNLOCK and self.LOCALSTATE == UNLOCK:
							self.changedoor = True
							self.LOCALSTATE = CATOUT
						elif self.SERVERSTATE == CATIN and self.LOCALSTATE == CATIN:
							self.changedoor = True
							self.LOCALSTATE = LOCKDOWN
						self.doc_ref.update({
							"cat_detected": False,
							"intruder_detected": True
						})
						print ("updating : intruders detected")
				elif self.new_label == "others":
					if self.isTimeOver:
						if self.SERVERSTATE == UNLOCK and self.LOCALSTATE == UNLOCK:
							self.changedoor = True
							self.LOCALSTATE = CATOUT
						elif self.SERVERSTATE == CATIN and self.LOCALSTATE == CATIN:
							self.changedoor = True
							self.LOCALSTATE = LOCKDOWN
						self.doc_ref.update({
								"cat_detected": False,
								"intruder_detected": False
							})
						print ("updating : nothing detected")

				self.current_label = self.new_label
			
			if self.current_label != "cat":
				# print("this is passed")
				self.end = time.time()
				# print(self.end - self.start)
				# print("delay: " + str(self.delay_after_cat.get()))
				if self.isCounting and self.end - self.start > self.delay_after_cat.get():
					self.isTimeOver = True
					self.isCounting = False
					if self.new_label != "others": ## intruders
						if self.SERVERSTATE == UNLOCK and self.LOCALSTATE == UNLOCK:
							self.changedoor = True
							self.LOCALSTATE = CATOUT
						elif self.SERVERSTATE == CATIN and self.LOCALSTATE == CATIN:
							self.changedoor = True
							self.LOCALSTATE = LOCKDOWN
						self.doc_ref.update({
							"cat_detected": False,
							"intruder_detected": True
						})
						print ("updating : intruders detected")

					elif self.new_label == "others":
						if self.SERVERSTATE == UNLOCK and self.LOCALSTATE == UNLOCK:
							self.changedoor = True
							self.LOCALSTATE = CATOUT
						elif self.SERVERSTATE == CATIN and self.LOCALSTATE == CATIN:
							self.changedoor = True
							self.LOCALSTATE = LOCKDOWN
						self.doc_ref.update({
								"cat_detected": False,
								"intruder_detected": False
							})
						print ("updating : nothing detected")	
					
			if self.changedoor:
				# sv.doorLock(doc[self.LOCALSTATE])
				print("door status changed: Server: " + self.SERVERSTATE + "// Local: " + self.LOCALSTATE)
				self.changedoor = False

			img_np = np.array(image_reader)
			image = cv2.cvtColor(img_np, cv2.COLOR_BGR2RGB)
			image = Image.fromarray(image)
			image = image.resize((700, 500), Image.ANTIALIAS)
			image = ImageTk.PhotoImage(image)
			if self.image_label is None:
				self.image_label = Label(image=image)
				self.image_label.image = image
				self.image_label.grid(row = 0, column = 0, columnspan = 1)
			else:
				self.image_label.configure(image=image)
				self.image_label.image = image  
		self.w.after(100, self.update)    
			

	def terminate(self):
		if(self.cap != None):
			self.cap.release()
			cv2.destroyAllWindows()
			self.alreadyrunning = False


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

	def on_snapshot(self, doc_snapshot, changes, read_time):
		for doc in doc_snapshot:
			print(u'Received document snapshot: {}'.format(doc.id))
			print(doc.to_dict())
			doc = doc.to_dict()

			## changedoor should not True when cat is just dtected and door is opened.
			## we should seperate on_snapshot change from a snapshot caused by a door's recognition against a 
			## snapshot of user's app.
			# sv.doorLock(doc[STATUS])
			state = doc[STATUS]
			if self.SERVERSTATE != state:
				self.SERVERSTATE = state
				if self.SERVERSTATE == UNLOCK:
					self.LOCALSTATE = CATOUT
					self.changedoor = True

				elif self.SERVERSTATE == LOCKDOWN:
					self.LOCALSTATE = LOCKDOWN
					self.changedoor = True
				
				elif self.SERVERSTATE == CATIN:
					self.LOCALSTATE = LOCKDOWN
					self.changedoor = True

				elif self.SERVERSTATE == CATOUT:
					self.LOCALSTATE = CATOUT
					self.changedoor = True




		 

cred = credentials.Certificate('serviceaccount.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

doc_id = "data"







doc_ref = db.collection(u'CatDoor').document(doc_id)

# Watch the document

# doc_watch = doc_ref.on_snapshot(on_snapshot)

# doc_ref= None


tk = Tk()
gui = gui(tk, doc_ref)
tk.mainloop()



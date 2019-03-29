from tkinter import *
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# # Use the application default credentials
# cred = credentials.ApplicationDefault()
# firebase_admin.initialize_app(cred, {
#   'projectId': "catdoor-642e4",
# })

# Use a service account

cred = credentials.Certificate('serviceaccount.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

catdoor_ref = db.collection(u'CatDoor')
docs = catdoor_ref.get()

doc_id = None

for doc in docs:
	doc_id = doc.id
	print(u'{} => {}'.format(doc.id, doc.to_dict()))


# class gui:
#   def __init__(self, w):
#     self.email_str = StringVar()
#     self.pass_str = StringVar()
#     email_label = Label(w, text = "email: ").pack()
#     email_entry = Entry(w, textvariable = self.email_str, fg = "black").pack()
#     pass_label = Label(w, text = "password: ").pack()
#     pass_entry = Entry(w, textvariable = self.pass_str, fg = "black").pack()
#     login_button = Button(w, text="Login").pack()


# Create a callback on_snapshot function to capture changes
def on_snapshot(doc_snapshot, changes, read_time):
	for doc in doc_snapshot:
		print(u'Received document snapshot: {}'.format(doc.id))
		print(doc.to_dict())
doc_ref = db.collection(u'CatDoor').document(doc_id)

# Watch the document

doc_watch = doc_ref.on_snapshot(on_snapshot)

while True:

	continue
# tk = Tk()
# gui = gui(tk)
# tk.mainloop()

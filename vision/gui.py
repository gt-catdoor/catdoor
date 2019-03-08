# -*- coding: utf-8 -*-
from converter import Converter
from tkinter import *



class converter_gui:

	def __init__(self, w):
		self.converter = Converter()
		self.page_counter = 0
		self.current_section = self.converter.section

		self.receive_year = StringVar()
		self.receive_month = StringVar()
		self.receive_day = StringVar()
		self.country_change_to = StringVar()
		self.document_change_to = StringVar()
		self.mark_select = IntVar()
		self.class_change_to = StringVar()
		self.issue_year = StringVar()
		self.issue_month = StringVar()
		self.issue_day = StringVar()
		self.issue_num = StringVar()
		self.issue_company_select = IntVar()

		self.page_list = StringVar()
		# self.class_of_goods = StringVar()

		receive_date_label = Label(w, text = "수신 날짜: ").grid(row = 1, column = 0, columnspan = 1)
		receive_year_entry = Entry(w, textvariable = self.receive_year, fg = "black").grid(row=1,column=1, padx = 5, pady = 5)
		year_label = Label(w, text = "년").grid(row = 1, column = 2, columnspan = 1)
		receive_month_entry = Entry(w, textvariable = self.receive_month, fg = "black").grid(row=1,column=3, padx = 5, pady = 5)
		month_label = Label(w, text = "월").grid(row = 1, column = 4, columnspan = 1)
		receive_day_entry = Entry(w, textvariable = self.receive_day, fg = "black").grid(row=1,column=5, padx = 5, pady = 5)
		day_label = Label(w, text = "일").grid(row = 1, column = 6, columnspan = 1)
        


		nation_label = Label(w, text = "상표출현 국가: ").grid(row = 2, column = 0, columnspan = 1)
		nation_label_entry = Entry(w, textvariable = self.country_change_to, fg = "black").grid(row=2,column=1, padx = 5, pady = 5)

		document_label = Label(w, text = "별첨 :").grid(row = 3, column = 0, columnspan = 1)
		document_entry = Entry(w, textvariable = self.document_change_to, fg = "black").grid(row=3,column=1, padx = 5, pady = 5)
		

		# trademark_label0 = Label(w, text = "상표 선택").grid(row = 4, column = 0, columnspan = 1)
		# trademark_radio0 = Radiobutton(w, text="HK Tech Group", variable = self.mark_select, value=0).grid(row=4, column = 1)
		# trademark_radio0 = Radiobutton(w, text="HK ATLASBX", variable = self.mark_select, value=1).grid(row=4, column = 2)
		# trademark_radio0 = Radiobutton(w, text="HK Innovative Tech", variable = self.mark_select, value=2).grid(row=4, column = 3)
			
		class_label = Label(w, text = "분류: ").grid(row = 5, column = 0, columnspan = 1)
		class_entry = Entry(w, textvariable = self.class_change_to, fg = "black").grid(row=5,column=1, padx = 5, pady = 5)
		class_label_explanation = Label(w, text = "입력 예) 12, 35     또는    12 35   (주의 : 숫자 이외의 문자열은 붙이지 마십시오)").grid(row = 5, column = 2, columnspan = 4)

		issue_date_label = Label(w, text = "출원 일자: ").grid(row = 6, column = 0, columnspan = 1)
		issue_year_entry = Entry(w, textvariable = self.issue_year , fg = "black").grid(row=6,column=1, padx = 5, pady = 5)
		issue_year_label = Label(w, text = "년").grid(row = 6, column = 2, columnspan = 1)
		issue_month_entry = Entry(w, textvariable = self.issue_month, fg = "black").grid(row=6,column=3, padx = 5, pady = 5)
		issue_month_label = Label(w, text = "월").grid(row = 6, column = 4, columnspan = 1)
		issue_day_entry = Entry(w, textvariable = self.issue_day, fg = "black").grid(row=6,column=5, padx = 5, pady = 5)
		issue_day_label = Label(w, text = "일").grid(row = 6, column = 6, columnspan = 1)

		issue_num_label = Label(w, text = "출원번호: ").grid(row = 7, column = 0, columnspan = 1)
		issue_num_entry = Entry(w, textvariable = self.issue_num, fg = "black").grid(row=7,column=1, padx = 5, pady = 5)

		issue_company_label = Label(w, text = "출원인: ").grid(row = 8, column = 0, columnspan = 1) 
		trademark_radio0 = Radiobutton(w, text="한국 타이어", variable = self.issue_company_select, value=0).grid(row=8, column = 1)
		trademark_radio0 = Radiobutton(w, text="한국 타이어 월드와이드", variable = self.issue_company_select, value=1).grid(row=8, column = 2)
			
		class_of_goods_label = Label(w, text = "지정상품: ").grid(row = 9, column = 0, columnspan = 1)
		self.class_of_goods_entry = Text(w, width = 30, height = 10)
		self.class_of_goods_entry.grid(row = 9, column = 1)

		add_page_button = Button(w, text="add page", command = self.add_page).grid(row=10,column=0, columnspan=1,pady = 5,sticky=W)
		convert_button = Button(w, text="xml 생성", command = self.convert_from_gui).grid(row=10,column=1, columnspan=1,pady = 5,sticky=E)

		self.page_list_show = Label(w, textvariable = self.page_list ).grid(row = 9, column = 3, columnspan = 1)
		

	def add_page(self):
		if self.page_counter > 0:
			self.current_section = self.converter.get_new_page()
		self.converter.change_receive_date(self.receive_year.get(), self.receive_month.get(), self.receive_day.get(), self.current_section)
		self.converter.change_nation(self.country_change_to.get(), self.current_section)
		self.converter.change_document(self.document_change_to.get(), self.current_section)
		self.converter.change_class(self.class_change_to.get(), self.current_section)
		self.converter.change_issue_num(self.issue_num.get(), self.current_section)
		self.converter.change_issue_date(self.issue_year.get(), self.issue_month.get(), self.issue_day.get(), self.current_section)
		self.converter.change_issue_company(self.issue_company_select.get(), self.current_section)
		self.converter.add_good(self.class_of_goods_entry.get("1.0", END), self.current_section)
		if self.page_counter > 0:
			self.converter.add_page_break(self.current_section)
		self.page_counter += 1
		self.page_list.set(self.page_list.get() + "\n" + self.country_change_to.get() +  \
			" 상표출원 " + self.converter.process_class_str(self.class_change_to.get()) + ")")
		self.class_change_to.set("")
		self.issue_num.set("")




	def convert_from_gui(self):
			self.add_page()
			self.converter.convert()




# year_change_to = '2018'
# month_change_to = '44'
# day_change_to = '4'

tk = Tk()
converter_gui = converter_gui(tk)
tk.mainloop()

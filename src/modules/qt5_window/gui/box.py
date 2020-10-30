# -*- coding: utf-8 -*-
# Copyright 2015 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
import os
import inject

from PyQt5 import QtCore
from PyQt5 import QtWidgets
from PyQt5 import QtGui

from PyQt5.QtCore import Qt

from .content import WindowContent
from .bar import Toolbar


class MessageBox(QtWidgets.QMessageBox):

    @inject.params(themes='themes')
    def __init__(self, parent, title, message, button1, button2, themes=None):
        super(MessageBox, self).__init__(parent)
        self.setWindowIcon(QtGui.QIcon("icons/tuner"))
        self.setStyleSheet(themes.get_stylesheet())
        self.setWindowTitle(title)

        self.setLayout(QtWidgets.QGridLayout())

        scroll = QtWidgets.QScrollArea(self)
        self.layout().addWidget(scroll, 0, 0, 2, 1)

        scroll.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        scroll.setStyleSheet("QScrollArea{min-width:500 px; min-height: 400px}")
        scroll.setWidgetResizable(True)

        self.content = QtWidgets.QWidget()
        self.content.setContentsMargins(0, 0, 0, 0)
        scroll.setWidget(self.content)

        layout = QtWidgets.QVBoxLayout(self.content)
        layout.addWidget(QtWidgets.QLabel(message, self))
        layout.setAlignment(Qt.AlignTop)

        self.addButton(button1)
        self.addButton(button2)
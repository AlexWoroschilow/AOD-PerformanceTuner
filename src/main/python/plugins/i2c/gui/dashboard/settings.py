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
import copy
import hexdi
import webbrowser

from PyQt5 import QtWidgets
from PyQt5.QtCore import Qt

from PyQt5 import QtCore
from PyQt5 import QtGui

from .slider import DashboardSlider


class DashboardSettings(QtWidgets.QWidget):

    @hexdi.inject('config')
    def __init__(self, config):
        super(DashboardSettings, self).__init__()
        self.setSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        self.setContentsMargins(0, 0, 0, 0)

        self.setLayout(QtWidgets.QGridLayout())

        value = config.get('i2c.performance', 'on')
        slider1 = DashboardSlider('AC- Adapter', 0 if value == 'auto' else 1)
        self.layout().addWidget(slider1, 0, 0)

        value = config.get('i2c.powersave', 'auto')
        slider2 = DashboardSlider('Battery', 0 if value == 'auto' else 1)
        self.layout().addWidget(slider2, 1, 0)

        slider1.slideAction.connect(self.actionSlidePerformance)
        slider2.slideAction.connect(self.actionSlidePowersave)

    @hexdi.inject('config')
    def actionSlidePerformance(self, value, config):
        if value is None: return None
        config.set('i2c.performance', 'auto' if value == 0 else 'on')

    @hexdi.inject('config')
    def actionSlidePowersave(self, value, config):
        if value is None: return None
        config.set('i2c.powersave', 'auto' if value == 0 else 'on')

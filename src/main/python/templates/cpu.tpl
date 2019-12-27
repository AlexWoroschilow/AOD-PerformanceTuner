#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright 2019 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITION
import os
import sys
import glob

ignored = [$ignored]
source = '/sys/devices/system/cpu'
if not os.path.exists(source): sys.exit()

for device in glob.glob('{}/cpu[0-9]*'.format(source)):
    if device in ignored:
        continue

    governor = '{}/cpufreq/scaling_governor'.format(device)
    if not os.path.exists(governor): continue
    with open(governor, 'w', errors='ignore') as stream:
        stream.write('$schema')

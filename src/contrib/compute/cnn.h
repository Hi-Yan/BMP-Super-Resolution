/******************************************************************************
The MIT License
Copyright (c) 2017-2018 Yeonji
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************************/

#ifndef YISR_CNN_H
#define YISR_CNN_H 1

#include <stdint.h>

#include <contrib/compute/compute.h>
#include <contrib/compute/compute_private.h>

int cnn_init(int buffer_cnt, int data_length);
int cnn_release(void);

int cnn_write_input_data(int buffer_id, float * data);
int cnn_push_input_data(float * data);
float * cnn_read_input_data(int buffer_id);
float * cnn_read_output_data(int buffer_id);

int cnn_full_conv2d_layer(float * filters, float * bias, 		\
    int input_cnt, int output_cnt, int input_w, int input_h,    \
    int filter_w, int filter_h, int dx, int dy );

int cnn_full_leaky_relu_layer(float rate);

int cnn_switch_next_layer(void);

#endif
/*************************************************************************
/* GPU Programmming
/* Author: Xuehai He
/* Copyright 2020
/* University of California, San Diego
/*************************************************************************/
#include <stdio.h>

//__device__ short* c_action;
short *d_action;

__global__ void Agent_action(int2* cstate, short* next_action) {
	int i = (*cstate).y; // location
	int j = (*cstate).x;

	int r = 0;
	int d = 1;
	int l = 2;

	if (i == 0 && j == 0) {
		*next_action = r;
	}
	else if (i == 0 && j == 1) {
		*next_action = r;
	}
	else if (i == 0 && j == 2) {
		*next_action = r;
	}
	else if (i == 0 && j == 3) {
		*next_action = d;
	}
	else if (i == 1 && j == 3) {
		*next_action = d;
	}
	else if (i == 2 && j == 3) {
		*next_action = l;
	}
	else { printf("The current position is: (%d, %d)", (*cstate).x, (*cstate).y); }
}

void agent_init()
{
	// add your codes
	cudaMalloc((void**)&d_action, sizeof(short));
	// *d_action = 0;
}

short* agent_action(int2* cstate)
{
	Agent_action << <1, 1 >> > (cstate, d_action);
	return d_action;
}
#!/bin/sh

# Start Docker daemon
dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375